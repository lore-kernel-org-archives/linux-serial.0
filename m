From: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Subject: Re: implement put_char() in cdc-acm
Date: Tue, 03 Nov 2015 09:58:14 +0100
Message-ID: <1446541094.27681.2.camel@suse.com>
References: <1445958479.2043.6.camel@suse.com>
	 <562F9C08.6050105@svenbrauch.de> <1446030280.15140.10.camel@suse.com>
	 <5630BE5E.6040204@hurleysoftware.com> <1446035622.15140.17.camel@suse.com>
	 <563667D9.9080401@svenbrauch.de> <1446463972.25345.24.camel@suse.com>
	 <5637C731.20409@svenbrauch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5637C731.20409-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Brauch <mail-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Mon, 2015-11-02 at 21:27 +0100, Sven Brauch wrote:
> On 02/11/15 12:32, Oliver Neukum wrote:
> > given this test I will submit the patch.
> Mind you, I don't know if the improvement is due to your patch or other
> things. I didn't test the new kernel without your patch; should I?

If you find the time. But testing with enlarged buffers is
more important.

> > Sven, can you ramp up the buffers in the manner Peter suggested
> > and retest? It looks like the throttling code isn't perfect yet,
> > but a larger buffer may make its performance good enough.
> I'll try as soon as possible, but I'm sceptical. That still doesn't
> guarantee that no data is lost, which feels bad to me.

That cannot be guaranteed on a remote line. Basically
your device is special by doing implied flow control
when the host stops requesting data.

	Regards
		Oliver


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
