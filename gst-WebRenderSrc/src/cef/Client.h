#ifndef CLIENT_H
#define	CLIENT_H

#include <functional>

#include <gst/gstinfo.h>

#include <include/cef_client.h>
#include <include/cef_render_handler.h>

class Client : 
    public CefClient,
    public CefRenderHandler,
    public CefLifeSpanHandler
{
public:
    typedef std::function<void(CefRect& rect)> GetRectCallback;
    class Listener {
    public: 
        virtual void OnPaint(CefRenderHandler::PaintElementType type, const CefRenderHandler::RectList& rects, const void* buffer, int width, int height)  = 0;
    };
public:
    Client(Listener *listener, GetRectCallback getRectCallback);
    virtual ~Client();
    
    //Overrride
    virtual CefRefPtr<CefRenderHandler> GetRenderHandler() override {
        // Return the handler for off-screen rendering events.
        return this;
    }
    virtual CefRefPtr<CefLifeSpanHandler> GetLifeSpanHandler() override {
        // Return browser life span handler
        return this;
    }
    
    virtual void GetViewRect(CefRefPtr<CefBrowser> browser, CefRect& rect) override;
    virtual void OnPaint(CefRefPtr<CefBrowser> browser, CefRenderHandler::PaintElementType type, const RectList& rects, const void* buffer, int width, int height) override;

    IMPLEMENT_REFCOUNTING(Client);
private:
    Listener* listener;
    GetRectCallback _getRectCallback;
};

#endif	/* CLIENT_H */
