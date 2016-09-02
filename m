From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v4 2/2] serial: 8250_dw: add ACPI support for uart on
 Hisilicon Hip05 SoC
Date: Fri, 2 Sep 2016 14:16:02 +0300
Message-ID: <20160902111602.GA21737@kuha.fi.intel.com>
References: <1472614152-43136-1-git-send-email-wangkefeng.wang@huawei.com>
 <1472614152-43136-3-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472614152-43136-3-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jiri Slaby <jslaby@suse.com>, guohanjun@huawei.com, xuwei5@hisilicon.com, graeme.gregory@linaro.org, z.liuxinliang@hisilicon.com, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 31, 2016 at 11:29:12AM +0800, Kefeng Wang wrote:
> Add ACPI identifier for UART on Hisilicon Hip05 SoC, be careful that
> it is not 16550 compatible, and "reg-io-width" and "reg-shift" need
> be set properly by _DSD method in DSDT.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


Thanks,

-- 
heikki
