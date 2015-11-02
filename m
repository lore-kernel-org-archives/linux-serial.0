From: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Subject: Re: implement put_char() in cdc-acm
Date: Mon, 02 Nov 2015 12:32:52 +0100
Message-ID: <1446463972.25345.24.camel@suse.com>
References: <1445958479.2043.6.camel@suse.com>
	 <562F9C08.6050105@svenbrauch.de> <1446030280.15140.10.camel@suse.com>
	 <5630BE5E.6040204@hurleysoftware.com> <1446035622.15140.17.camel@suse.com>
	 <563667D9.9080401@svenbrauch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <563667D9.9080401-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Brauch <mail-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Sun, 2015-11-01 at 20:28 +0100, Sven Brauch wrote:
> I cloned that tree (git describe said v4.3-rc5), and applied Oliver's
> patch. With that kernel booted, the error occured much less
> frequently,
> but was still reproducable under load. With 4.2.5, I get a failure
> after
> a few hundred MB; with 4.3-rc5 plus patch, it transferred serveral
> gigabytes
> without errors, but failed when I started compiling something in the
> background as a test.

Hi,

given this test I will submit the patch.
Sven, can you ramp up the buffers in the manner Peter suggested
and retest? It looks like the throttling code isn't perfect yet,
but a larger buffer may make its performance good enough.

	Regards
		Oliver


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
