From: Juergen Borleis <jbe@pengutronix.de>
Subject: Re: [PATCH v3] serial: mxs-auart: keep the AUART unit in reset state when not in use
Date: Mon, 20 Jul 2015 15:18:58 +0200
Message-ID: <201507201518.58720.jbe@pengutronix.de>
References: <1437032458-8577-1-git-send-email-jbe@pengutronix.de> <201507201004.02646.jbe@pengutronix.de> <55ACF0E5.6040107@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55ACF0E5.6040107@hurleysoftware.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel@pengutronix.de
Cc: Peter Hurley <peter@hurleysoftware.com>, Stefan Wahren <stefan.wahren@i2se.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On Monday 20 July 2015 15:00:21 Peter Hurley wrote:
> [...]
> > mxs_auart_reset() is a bad name from the beginning. But I just want=
ed to
> > keep this change small and only change things that are really requi=
red. I
> > will try with a V4.
>
> ISTM this should be split into 2 or 3 separate patches:
> 1. Rename mxs_auart_reset()
> 2. Fix stale rx on re-open
> 3. Reset @ probe

Okay.

Regards,
Juergen

--=20
Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Juergen Borleis =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| http://www.pengutronix.de/ =C2=A0|
