From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: Suggested patch for linux
Date: Tue, 15 Jul 2008 21:46:19 +0100
Message-ID: <20080715214619.3fe8728c@the-village.bc.nu>
References: <487546D5.8050908@freesurf.ch>
	<20080710095904.16dfdb08@the-village.bc.nu>
	<487619C8.7080509@commtech-fastcom.com>
	<20080712233317.05e3b6e5@lxorguk.ukuu.org.uk>
	<1860bbce0807151343rf5cf4apecdc422ba747dd7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1860bbce0807151343rf5cf4apecdc422ba747dd7d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Schulte <matts-bKQEqc8oQVCV2t6uauB/CFaTQe2KTcn/@public.gmane.org>
Cc: Axel Hosemann <axel.hosemann-3sKltW3hOZofv37vnLkPlQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

> The chips may or may not be safe, that isn't the point.  There are
> real world applications where response time is an issue and meeting
> these criteria is sometimes impossible from a user application.
> Switching to an RTOS is certainly an option, it would very likely

Firstly: Linux has an RT patch and its expected to get merged soon
Second: Linux has RT processes already
Third: A non RT Linux kernel space and user space will not give much
different performance

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
