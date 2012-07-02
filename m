From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 5/6] x86: add CONFIG_ARM_AMBA, selected by STA2X11
Date: Mon, 2 Jul 2012 16:58:27 +0000
Message-ID: <201207021658.27755.arnd@arndb.de>
References: <4FECB95D.7010200@zytor.com> <20120701104401.GA4352@mail.gnudd.com> <2b797c83-6a3c-4051-841a-a4cfa9d1cae1@email.android.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <2b797c83-6a3c-4051-841a-a4cfa9d1cae1@email.android.com>
Sender: linux-arch-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alessandro Rubini <rubini@gnudd.com>, linux-kernel@vger.kernel.org, giancarlo.asnaghi@st.com, alan@linux.intel.com, linux@arm.linux.org.uk, x86@kernel.org, gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sunday 01 July 2012, H. Peter Anvin wrote:
> 
> There is no problem with adding ARM or !X86 dependencies to drivers
> now and fixing them later or as required.

Right, but if the fix is trivial (e.g. missing #include statement), it's
usually better to just fix the code.

Also, in many cases it's possible to say specifically what some code depends
on. E.g. if a driver uses clk_get/clk_put, it should depend on CLKDEV_LOOKUP,
not on !X86.

	Arnd
