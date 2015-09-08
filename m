From: Mark Salter <msalter@redhat.com>
Subject: Re: [Linaro-acpi] [RFC 3/5] acpi/serial: add DBG2 earlycon support
Date: Tue, 08 Sep 2015 13:53:27 -0400
Message-ID: <1441734807.5459.18.camel@redhat.com>
References: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
	 <1441716217-23786-4-git-send-email-leif.lindholm@linaro.org>
	 <1441730339.5459.8.camel@redhat.com>
	 <20150908171744.GQ10728@bivouac.eciton.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150908171744.GQ10728@bivouac.eciton.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Leif Lindholm <leif.lindholm@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, torez@redhat.com, lv.zheng@intel.com
List-Id: linux-serial@vger.kernel.org

On Tue, 2015-09-08 at 18:17 +0100, Leif Lindholm wrote:
> > >      */
> > > -   if (!buf || !buf[0])
> > > -           if (IS_ENABLED(CONFIG_OF_FLATTREE))
> > > +   if (!buf || !buf[0]) {
> > > +           if (!acpi_disabled)
> > 
> > How do we know for sure that "acpi" has been parsed before "earlycon"?
> 
> Because "arch" comes before "drivers" in kernel image link order.
> *twitch*
> Yes, not the best argument ever.
> 

I don't think that matters. Things are parsed in order they are
found on cmdline (except for early vs late distinction).

