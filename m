From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] serial: vt8500_serial: Fix a parameter of find_first_zero_bit.
Date: Wed, 24 Aug 2016 09:21:26 +0200
Message-ID: <10942927.gm6yg0F9Sl@wuerfel>
References: <1472015218-31826-1-git-send-email-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472015218-31826-1-git-send-email-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux@prisktech.co.nz, gregkh@linuxfoundation.org, jslaby@suse.com, kernel-janitors@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wednesday, August 24, 2016 7:06:58 AM CEST Christophe JAILLET wrote:
> The 2nd parameter of 'find_first_zero_bit' is the number of bits to search.
> In this case, we are passing 'sizeof(vt8500_ports_in_use)'.
> 'vt8500_ports_in_use' is an 'unsigned long'. So the sizeof is likely to
> return 4 on a 32 bits kernel.
> 
> A few lines below, we check if it is below VT8500_MAX_PORTS, which is 6.
> 
> It is likely that the number of bits in a long was expected here.
> 
> In order to fix it:
>    - use DECLARE_BITMAP when declaring the vt8500_ports_in_use
>    - use VT8500_MAX_PORTS as a maximum value when checking/setting bits in
>      this bitmap
>    - modify code now that 'vt8500_ports_in_use' has become a pointer
>      because of the use of DECLARE_BITMAP
> 
> 
> It has been spotted by the following coccinelle script:
> @@
> expression ret, x;
> 
> @@
> *  ret = \(find_first_bit \| find_first_zero_bit\) (x, sizeof(...));
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: - use of VT8500_MAX_PORTS instead of BITS_PER_LONG to better self
>       document the code
>     - declare vt8500_ports_in_use with DECLARE_BITMAP in order to self
>       document even better and to be foolproof should VT8500_MAX_PORTS
>       be changed one day

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
