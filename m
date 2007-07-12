From: Alistair John Strachan <alistair@devzero.co.uk>
Subject: Re: [PATCH] sb1250-duart.c: SB1250 DUART serial support
Date: Thu, 12 Jul 2007 20:15:11 +0100
Message-ID: <200707122015.12078.alistair@devzero.co.uk>
References: <Pine.LNX.4.64N.0707121745010.3029@blysk.ds.pg.gda.pl> <469669F5.6070906@shadowen.org> <Pine.LNX.4.64N.0707121904211.3029@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <Pine.LNX.4.64N.0707121904211.3029@blysk.ds.pg.gda.pl>
Content-Disposition: inline
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>, Mark Mason <mason@broadcom.com>, Randy Dunlap <rdunlap@xenotime.net>, Joel Schopp <jschopp@austin.ibm.com>, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thursday 12 July 2007 19:16:20 Maciej W. Rozycki wrote:
> On Thu, 12 Jul 2007, Andy Whitcroft wrote:
[snip]
> > WARNING: declaring multiple variables together should be avoided
> > #372: FILE: drivers/serial/sb1250-duart.c:246:
> > +	unsigned int mctrl, status;
>
>  Well, this is probably superfluous -- why would anyone prefer:
>
> 	int r0;
> 	int r1;
> 	int r2;
> 	int r3;
> 	int r4;
>
> to:
>
> 	int r0, r1, r2, r3, r4;
>
> unconditionally?

Imagine you're working on a piece of kernel code that has a lot of parallel 
churn. Conflicts on lines like "int a,b,c,d;" are more likely to cause Andrew 
et al pain, which I guess is the rationale for discouraging it. Conversely, 
if the variables are kept separate, diff handles it fine.

I think as long as the variables are logically grouped, the pain is minimised, 
but there's a few good reasons for the verbose style.

-- 
Cheers,
Alistair.

137/1 Warrender Park Road, Edinburgh, UK.
