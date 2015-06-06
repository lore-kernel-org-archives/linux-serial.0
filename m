From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH RFC 0/3] UART slave device support
Date: Sat, 6 Jun 2015 15:09:41 +0200
Message-ID: <20150606130941.GA1329@xo-6d-61-c0.localdomain>
References: <20150506141547.GB1764@leverpostej>
 <EA4AC398-CAEA-40E1-A998-BC528B3788E1@goldelico.com>
 <20150506171802.GE2974@leverpostej>
 <B4D487C5-C260-497B-A441-6C381D53616C@goldelico.com>
 <554B7D33.602@hurleysoftware.com>
 <9EF54D80-F634-4D59-BFD9-FC79FCFE06DE@goldelico.com>
 <554B8A14.2080904@hurleysoftware.com>
 <21C337B3-D612-4931-BA23-6B7518E6E4DD@goldelico.com>
 <112A49DF-935D-41DF-8DF7-F04CC13B9598@goldelico.com>
 <56C579D3-E8F8-4B5A-B6E8-993B113F3461@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56C579D3-E8F8-4B5A-B6E8-993B113F3461-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Dr. H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, List for communicating with real GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed 2015-06-03 13:49:30, Dr. H. Nikolaus Schaller wrote:
> Hi all,
> this patch series is our proposal to add hooks so that the driver for a device connected to an UART can
> monitor modem control lines and data activity of the connected chip.
> 
> It contains an example for such a device driver which needs such sophisticated power control: wi2wi,w2sg0004
> 
> A remote device connected to a RS232 interface is usually power controlled by the DTR line.
> The DTR line is managed automatically by the UART driver for open() and close() syscalls
> and on demand by tcsetattr().
> 
> With embedded devices, the serial peripheral might be directly and always connected to the UART
> and there might be no physical DTR line involved. Power control (on/off) has to be done by some
> chip specific device driver (which we call "UART slave") through some mechanisms (I2C, GPIOs etc.)
> not related to the serial interface. Some devices do not tell their power state except by sending
> or not sending data to the UART. In such a case the device driver must be able to monitor data
> activity. The role of the device driver is to encapsulate such power control in a single place.
> 
> This patch series allows to support such UART slave drivers by providing:
> * a mechanism that a slave driver can identify the UART instance it is connected to
> * a mechanism that UART slave drivers can register to be notified
> * notfications for DTR (and other modem control) state changes
> * notifications that the device has sent some data to the UART
> 
> A slave device tree entry simply adds a phandle reference to the UART it is connected to, e.g.
> 
> 	gps {
> 		compatible = "wi2wi,w2sg0004";
> 		uart = <&uart1>;
> 	};

Device tree maintainers repeatedly pointed out this is not a way to go.

NAK.

										Pavel

> 
> The slave driver calls devm_serial_get_uart_by_phandle() to identify the uart driver.
> devm_serial_get_uart_by_phandle() follows the concept of devm_usb_get_phy_by_phandle().
> 
> A slave device driver registers itself with serial_register_slave() to receive notifications.
> Notification handlers can be registered by serial_register_mctrl_notification() and
> serial_register_rx_notification(). If an UART has a NULL slave or a NULL handler registered,
> no notifications are sent.
> 
> RX notification handlers can define a ktermios setup and modify or decide to throw away the
> character that is passed upwards.
> 
> This all is a follow-up to the w2sg0004 driver submitted in 2014 that did want to add an optional
> GPIO to DTR in omap-serial.c and required the w2sg0004 driver to present itself as a "virtual
> GPIO". The idea of a "virtual GPIO"  is not compatible with the concept that DT must
> describe hardware (and not virtual hardware). So in this new solution DT only describes that
> the w2sg0004 is connected to some UART and how the power state signalling works is left
> to the driver implementations.
> 
> The rx data notification also removes the concept of having two different pinmux states
> and make the w2sg0004 driver intercept rx activities by switching the rx line to a GPIO
> interrupt. This was very OMAP3 specific. The new solution is generic and might even be
> extensible that the chip driver could filter or consume the rx data before it is passed
> to the tty layer.
> 
> This patch works on linux-next as intended except one major weakness: we have to call 
> uart_change_speed() each time we open the tty. This is the opposite of what we would like
> to have: that the slave initializes the uart speed through some termios and the tty level just uses
> this setting. We have not yet completely understood how to make this work and are happy
> about help in this area.
> 
> And of course we would like to see general comments about the whole implementation
> approach.
> 
> 
> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
