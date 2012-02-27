From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] Clear previous interrupts after fifo is disabled
Date: Mon, 27 Feb 2012 14:54:22 +0100
Message-ID: <CACRpkdYxR7B_ozu7er8korgkkJBjmYYzw-TANzqZxK-ri7b4Wg@mail.gmail.com>
References: <CAOAMb1ASB0zznSSOAU9HgPNW2e=Do+8hSJ6JZ00DxtAxqsXyXQ@mail.gmail.com>
	<20120227104858.GR22562@n2100.arm.linux.org.uk>
	<20120227110204.GA30199@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120227110204.GA30199@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Chanho Min <chanho0207@gmail.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>, "Kim, Jong-Sung" <neidhard.kim@lge.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Feb 27, 2012 at 12:02 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Feb 27, 2012 at 10:48:58AM +0000, Russell King - ARM Linux wr=
ote:
>> I'd much prefer to only clear those interrupts which actually need t=
o be
>> cleared at this point. =A0So, I'd suggest this approach instead:
>
> Thinking about this a little more, we definitely want to mask and cle=
ar
> interrupts at probe time as well:

Acked-by: Linus Walleij <linus.walleij@linaro.org>

On the RMK-improved patch.

Thanks,
Linus Walleij
