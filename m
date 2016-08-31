From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_dw: Use an unified new dev variable in probe
Date: Wed, 31 Aug 2016 12:29:14 +0300
Message-ID: <20160831092914.GE1751@kuha.fi.intel.com>
References: <1472614027-42962-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472614027-42962-1-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jiri Slaby <jslaby@suse.com>, guohanjun@huawei.com
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 31, 2016 at 11:27:07AM +0800, Kefeng Wang wrote:
> Use an unified new dev variable instead of &pdev->dev and p->dev
> in probe function.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks,

-- 
heikki
