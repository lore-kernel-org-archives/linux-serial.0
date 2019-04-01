From: Ulrich Hecht <uli@fpond.eu>
Subject: Re: [PATCH] serial: sh-sci: Fix HSCIF RX sampling point calculation
Date: Mon, 1 Apr 2019 17:05:18 +0200 (CEST)
Message-ID: <805637056.1640115.1554131118962@webmail.strato.com>
References: <20190401112510.23145-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401112510.23145-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ulrich Hecht <uli+renesas@fpond.eu>
Cc: Eugeniu Rosca <erosca@de.adit-jv.com>, Dirk Behme <dirk.behme@de.bosch.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


> On April 1, 2019 at 1:25 PM Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> 
> 
> There are several issues with the formula used for calculating the
> deviation from the intended rate:
>   1. While min_err and last_stop are signed, srr and baud are unsigned.
>      Hence the signed values are promoted to unsigned, which will lead
>      to a bogus value of deviation if min_err is negative,
>   2. Srr is the register field value, which is one less than the actual
>      sampling rate factor,
>   3. The divisions do not use rounding.
> 
> Fix this by casting unsigned variables to int, adding one to srr, and
> using a single DIV_ROUND_CLOSEST().
> 
> Fixes: 63ba1e00f178a448 ("serial: sh-sci: Support for HSCIF RX sampling point adjustment")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli
