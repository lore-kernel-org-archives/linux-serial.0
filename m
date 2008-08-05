From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Tue, 5 Aug 2008 11:34:56 +0200
Message-ID: <001901c8f6de$85c4d0e0$2e01a8c0@acksys.local>
References: <g77f8p$plq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp03.msg.oleane.net ([62.161.4.3]:57223 "EHLO
	smtp03.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599AbYHJO7G (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 10 Aug 2008 10:59:06 -0400
In-Reply-To: <g77f8p$plq$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Grant Edwards' <grante@visi.com>, linux-serial@vger.kernel.org

I agree with your understanding of the standard.

I guess that the Oxford guys wanted to keep the possibility of using both
RTS input flow control AND half-duplex.

JP Tosoni

> -----Original Message-----
> From: linux-serial-owner@vger.kernel.org
> [mailto:linux-serial-owner@vger.kernel.org]On Behalf Of Grant Edwards
> Sent: Monday, August 04, 2008 7:46 PM
> To: linux-serial@vger.kernel.org
> Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
>
>
> On 2008-08-04, Tosoni <jp.tosoni@acksys.fr> wrote:
>
> > Last remark:
> >
> > Interestingly, the RTS envelope on the Oxford chips is
> > implemented with... the DTR pin. On our cards we have a piece
> > of hardware which redirect the uart DTR pin to the external
> > RTS in this case.
>
> Well, that's just plain wrong.  The RS-232 standard was quite
> clear that RTS is what's used to enable transmission.  ;)
>
> --
> Grant Edwards                   grante             Yow! I
> have a VISION!  It's
>                                   at               a RANCID
> double-FISHWICH on
>                                visi.com            an ENRICHED BUN!!
>
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

