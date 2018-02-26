From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
Date: Mon, 26 Feb 2018 14:27:43 +0200
Message-ID: <1519648063.10722.185.camel@linux.intel.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
         <1519381801.10722.103.camel@linux.intel.com>
         <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
         <1519407117.10722.124.camel@linux.intel.com>
         <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
         <1519638828.10722.153.camel@linux.intel.com>
         <7221877b-a84a-63a1-ef86-1991f358df72@huawei.com>
         <1519644517.10722.179.camel@linux.intel.com>
         <b5904a5a-66d8-4385-cc5b-a52529e9d28f@huawei.com>
         <1519647669.10722.184.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519647669.10722.184.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>, gregkh@linuxfoundation.org, jslaby@suse.com, p.zabel@pengutronix.de, heiko@sntech.de, ed.blake@sondrel.com, jhogan@kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com
List-Id: linux-serial@vger.kernel.org

On Mon, 2018-02-26 at 14:21 +0200, Andy Shevchenko wrote:
> On Mon, 2018-02-26 at 11:56 +0000, John Garry wrote:


> >    Device (LPC0.CON0) {
> >      Name (_HID, "HISI1031")

> >      // Name (_CID, "PNP0501") // cannot support PNP


One more question. What is the problem with this CID? Do you have a race
condition in enumeration?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
