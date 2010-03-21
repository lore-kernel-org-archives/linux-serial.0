From: christian pellegrin <chripell@fsfe.org>
Subject: Re: [PATCH 2/3] max3100: moved to threaded interrupt
Date: Sun, 21 Mar 2010 08:34:50 +0100
Message-ID: <cabda6421003210034j39a2f64ava6ad0648aa6ee1a3@mail.gmail.com>
References: <cabda6421003190139h344bc172h3556fca78e4b25cb@mail.gmail.com>
	 <1268987973-22719-1-git-send-email-chripell@fsfe.org>
	 <fa686aa41003191058o20e1c9cakb9684275bee78ca4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:7192 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab0CUHew convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 21 Mar 2010 03:34:52 -0400
Received: by fg-out-1718.google.com with SMTP id l26so117451fgb.1
        for <linux-serial@vger.kernel.org>; Sun, 21 Mar 2010 00:34:50 -0700 (PDT)
In-Reply-To: <fa686aa41003191058o20e1c9cakb9684275bee78ca4@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: feng.tang@intel.com, akpm@linux-foundation.org, greg@kroah.com, david-b@pacbell.net, alan@lxorguk.ukuu.org.uk, spi-devel-general@lists.sourceforge.net, linux-serial@vger.kernel.org

Hi,

On Fri, Mar 19, 2010 at 6:58 PM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
>
> On a quick parse, it seems mostly okay. =A0I haven't dug into the dri=
ver
> execution flow though. =A0A few minor comments below.
>

thank you very much for the review. I'm waiting a bit for other people
to comment and then prepare another patch.


>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 resume_work);
>
> container_of is used a lot. =A0Maybe consider a follow-on patch to
> create a to_max3100_port() static inline.
>

ack

>> +static irqreturn_t max3100_ist(int irq, void *dev_id)
>
> 'ist'?
>

interrupt service thread (compared to isr, interrupt service routine,
for the code executed in hard interrupt context). I know it's
windozece-speak and so *very lame*. Any suggestion for a better name
is welcome!


--=20
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
