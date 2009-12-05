From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/2] Uart driver for ST Microelectronics
 ConneXt(STA2X11/STA2X10).
Date: Fri, 4 Dec 2009 16:15:15 -0800
Message-ID: <20091204161515.3e2538e3@jbarnes-piketon>
References: <52CF90264091A14888078A031D780F436EF0F9@ism-mail03.corp.ad.wrs.com>
	<52CF90264091A14888078A031D780F4302F89334@ism-mail03.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <52CF90264091A14888078A031D780F4302F89334@ism-mail03.corp.ad.wrs.com>
Sender: linux-pci-owner@vger.kernel.org
To: "Feng, Xiaobing" <Xiaobing.Feng@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-pci@vger.kernel.org, giancarlo.asnaghi@st.com, "Wallin, Anders" <Anders.Wallin@windriver.com>, "D'Agostino, Raffaele" <raffaele.dagostino@windriver.com>, "Li, Li" <Li.Li@windriver.com>
List-Id: linux-serial@vger.kernel.org

On Mon, 16 Nov 2009 04:22:31 +0100
"Feng, Xiaobing" <Xiaobing.Feng@windriver.com> wrote:

> 
> Hi
> 	The  patch add VENDOR ID and DEVICE ID for all components on
> ST Microelectronics ConneXt board. It will be required by all drivers
> of ConneXt which will submit in the future monthes.
>   
> ST Microelectronics ConneXt(STA2X11/STA2X10), a PCI express
> multifunction chip that provides Input/Output capabilities.
> 
>   	 This patch has been checked by scripts/checkpatch.pl .

I'm assuming these IDs will be used by several source files?  If so,
then yeah they belong in pci_ids.h.  Unfortunately the patch didn't
apply, can you resend a new one against my linux-next branch?

The GPIO and serial drivers can probably go in via Andrew.

-- 
Jesse Barnes, Intel Open Source Technology Center
