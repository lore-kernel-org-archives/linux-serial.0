From: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: [PATCH] tty_ioctl: Fix the baud_table check in encode_baud_rate
Date: Wed, 17 Oct 2007 01:05:39 +0200
Message-ID: <471543C3.3050502@tiscali.nl>
References: <Pine.LNX.4.64N.0710161857280.22596@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965640AbXJPXGP@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64N.0710161857280.22596@blysk.ds.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Since you were sending a fix, possibly I shouldn't comment on this. If so please disregard my
suggestion for a trivial cleanup.

Roel

Maciej W. Rozycki wrote:
> +void tty_termios_encode_baud_rate(struct ktermios *termios,
> +				  speed_t ibaud, speed_t obaud)
>  {
>  	int i = 0;
>  	int ifound = -1, ofound = -1;
> @@ -251,12 +252,15 @@ void tty_termios_encode_baud_rate(struct
>  	termios->c_cflag &= ~CBAUD;
>  
>  	do {
> -		if (obaud - oclose >= baud_table[i] && obaud + oclose <= baud_table[i]) {
> +		if (obaud - oclose <= baud_table[i] &&
> +		    obaud + oclose >= baud_table[i]) {

if(a - b <= c && a + b >= c)
if(a <= c + b && a + b >= c)
if(c + b >= a && a + b >= c)
if(b >= a - c && b >= c - a)
true, if:
b >= |a - c|
so
		if (oclose >= abs(obaud - baud_table[i])) {

should work as well

>  			termios->c_cflag |= baud_bits[i];
>  			ofound = i;
>  		}
> -		if (ibaud - iclose >= baud_table[i] && ibaud + iclose <= baud_table[i]) {
> -			/* For the case input == output don't set IBAUD bits if the user didn't do so */
> +		if (ibaud - iclose <= baud_table[i] &&
> +		    ibaud + iclose >= baud_table[i]) {

similarly,
		if (iclose >= abs(ibaud - baud_table[i])) {

> +			/* For the case input == output don't set IBAUD bits
> +			   if the user didn't do so */
>  			if (ofound != i || ibinput)
>  				termios->c_cflag |= (baud_bits[i] << IBSHIFT);
>  			ifound = i;
