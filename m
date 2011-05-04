From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: Re: [RFC 1/5] platform-drivers-x86: add support for Technologic Systems TS-5xxx detection
Date: Wed, 04 May 2011 11:15:50 -0400
Message-ID: <1304520382-sup-3361@sfl>
References: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com> <1304115712-5299-2-git-send-email-vivien.didelot@savoirfairelinux.com> <20110430110705.5ca3376b@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-reply-to: <20110430110705.5ca3376b@lxorguk.ukuu.org.uk>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jonas Fonseca <jonas.fonseca@savoirfairelinux.com>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>
List-Id: linux-serial@vger.kernel.org

Excerpts from Alan Cox's message of 2011-04-30 06:07:05 -0400:
> > +
> > +/**
> > + * ts_sbcinfo_detect() - detect the TS board
> > + * @sbcinfo:        structure where to store the detected board's info.
> > + */
> > +static int ts_sbcinfo_detect(struct ts5xxx_sbcinfo *sbcinfo)
> > +{
> > +    u8 temp;
> > +    struct ts_sbc_config *sbc;
> > +    int ret = 0;
> > +
> > +    memset(sbcinfo, 0, sizeof(*sbcinfo));
> > +
> > +    if (!request_region(IOADDR_SBCID, 4, "TS-SBC"))
> > +        return -EBUSY;
> > +
> > +    temp = inb(IOADDR_SBCID);
> > +    /* If it is a 3x00 SBC only match against the first 3 bits */
> > +    if (temp & 0x07)
> > +        temp &= 0x07;
> 
> So if this is compiled into a kernel we blindly inb this address and some
> platform just crashed on boot. Is this board like other embedded ones in
> that there is some safe way to check if its such a board first ?
> 

It is possible to make a BIOS call (Int 15h / Function B000h) to get
board information, like the manufacturer ("TS"). It should be a safer
way to check if we are on a Technologic Systems board. a intcall(0x15,
&ireg, &oreg) should do the trick to check the platform, before checking
the SBC ID. What do you think?

Thanks,
Vivien.
