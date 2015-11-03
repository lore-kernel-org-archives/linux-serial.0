From: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Subject: Re: implement put_char() in cdc-acm
Date: Tue, 03 Nov 2015 11:19:43 +0100
Message-ID: <1446545983.27681.17.camel@suse.com>
References: <1445958479.2043.6.camel@suse.com>
	 <562F9C08.6050105@svenbrauch.de> <1446030280.15140.10.camel@suse.com>
	 <5630BE5E.6040204@hurleysoftware.com> <1446035622.15140.17.camel@suse.com>
	 <563667D9.9080401@svenbrauch.de> <1446463972.25345.24.camel@suse.com>
	 <5637C731.20409@svenbrauch.de> <1446541094.27681.2.camel@suse.com>
	 <563888BB.2080601@svenbrauch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <563888BB.2080601-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Brauch <mail-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2015-11-03 at 11:13 +0100, Sven Brauch wrote:
> On 03/11/15 09:58, Oliver Neukum wrote:
> > Basically
> > your device is special by doing implied flow control
> > when the host stops requesting data.
> Hmm, ok, interesting. But isn't that what always happens for USB bulk
> transfers, which is always the transport layer for the driver in question?

Usual communications devices have a channel, like a phone line, on
the other side, through which data keeps coming. You cannot just
stop transferring from the device to the host and hope to preserve
all data.

	Regards
		Oliver


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
