From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v5 0/7] add virt-dma support for imx-sdma
Date: Mon, 2 Jul 2018 18:47:37 +0530
Message-ID: <20180702131737.GJ22377@vkoul-mobl>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
 <1530025442.9910.44.camel@pengutronix.de>
 <1530527489.15665.22.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530527489.15665.22.camel@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Gong <yibin.gong@nxp.com>
Cc: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-serial@vger.kernel.org

On 02-07-18, 02:32, Robin Gong wrote:
> Hi Vinod,
> 	Do you have any comment for this patchset? Lucas and Sascha
> acked it and tty patch already merged in.

I was actually waiting for ACK/action on patch 1 :)

I have reviewed the series, some nitpicks nothing major, so I have
applied this good cleanup and conversion :) along with fixes for typos
in code, GFP_ fix and removed unused variable.

My buildchain noticed warns (with W=1) on this file, esp now that
structs are moved around. Pls fix the struct descriptions.

Thanks
-- 
~Vinod
