From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 3/9] serial: doc: Document .throttle()
Date: Wed, 16 Mar 2016 09:39:52 -0700
Message-ID: <56E98C58.1030408@hurleysoftware.com>
References: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
 <1457968577-22379-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1457968577-22379-4-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Russell King <rmk@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>, linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/14/2016 08:16 AM, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/serial/driver | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/serial/driver b/Documentation/serial/driver
> index 61d520dea4c6e13a..50f3d94ed50b341e 100644
> --- a/Documentation/serial/driver
> +++ b/Documentation/serial/driver
> @@ -126,6 +126,13 @@ hardware.
>  	Interrupts: locally disabled.
>  	This call must not sleep
>  
> +  throttle(port)
> +	Notify the serial driver that input buffers for the line discipline are
> +	close to full, and it should somehow signal that no more characters
> +	should be sent to the serial port.
> +
> +	Locking: none.

While it's true that no _serial_ locking is performed, the tty core
serializes throttle() and unthrottle(), and further guarantees termios
values will not be modified concurrently with throttle()/unthrottle().


> +
>    send_xchar(port,ch)
>  	Transmit a high priority character, even if the port is stopped.
>  	This is used to implement XON/XOFF flow control and tcflow().  If
> 

