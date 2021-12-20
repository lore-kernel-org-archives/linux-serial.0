Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DFEC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 20 Dec 2021 10:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhLTKq3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Dec 2021 05:46:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:11672 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhLTKq3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Dec 2021 05:46:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="226997781"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="226997781"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 02:46:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="684225277"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 02:46:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mzGA9-0001Nz-NB;
        Mon, 20 Dec 2021 12:45:01 +0200
Date:   Mon, 20 Dec 2021 12:45:01 +0200
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Jun Miao <jun.miao@intel.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [BUG report]: serial8250 unbind/bind failture
Message-ID: <YcBerZTJYCoGj44L@smile.fi.intel.com>
References: <DM6PR11MB47391ECD2402AB4F521DAC869A7B9@DM6PR11MB4739.namprd11.prod.outlook.com>
 <YcBThJYwRk1i9emo@kroah.com>
 <3f82cdd9-c1d9-2dfb-45b0-55d0a419c96a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f82cdd9-c1d9-2dfb-45b0-55d0a419c96a@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Dec 20, 2021 at 09:08:19PM +0800, Jun Miao wrote:
> On 2021/12/20 17:57, gregkh@linuxfoundation.org wrote:
> > On Mon, Dec 20, 2021 at 09:54:41AM +0000, Miao, Jun wrote:
> > > [Hardware]
> > > Intel Corporation Alder Lake Client Platform/AlderLake-M LP5 RVP, BIOS ADLPFWI1.R00.2265.A01.2107010436 07/01/2021
> > > About x86 old UART, not the PNP device.
> > > 
> > > [how to reproduce]
> > > root@ALD-M:/sys/devices/platform/serial8250/tty/ttyS0/device/driver# echo -n "serial8250" > unbind
> > > root@ALD-M:/sys/devices/platform/serial8250/tty/ttyS0/device/driver# echo -n "serial8250" > bind
> > After you unbound, this device is gone, so how does this path still
> > work?
> > 
> > > [What`s my Confusion]
> > > After the unbind and bind the serial8250_probe cannot register ttyS0.
> > Then do not do that :)
> 
> Hi maintainer,
> 
> Thanks your reply so quickly.
> 
> You mean, this operation is useless and should don`t do that.
> 
> But , if this is a PNP device,  it can probe successfully after unbind/bind.
> 
> > 
> > > And there is not dmesg like this: "serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A".
> > > 
> > > Any one have some advice about 8250 serial ?  It is a common operation if we believe that the old UART which don`t support like this unbind. Or we ignore about this really bug before?
> > What are you trying to do here exactly?  Why are you wanting to unbind
> > the driver from this device?  Why do you then want to bind it again?
> > What problem are you trying to solve by doing this?

> There is a testcase to test UART by unbind/bind.   i want to support it on
> old uart  of serial8250 .

It's fine to perform such test case (and I have done myself many times similar
operations, but not against PNP UART). Anyway as Greg told you the device is gone
I'm not sure if there is any kernel version which ever worked with what you are
suggesting. What you need is to find a device in the sysfs which corresponds your
PNP UART and perform this against that device.

I have my examples in the script for non-PNP ones:

rebind() {
        local drvdir="/sys/bus/$1/drivers/$2"
        local devdir="/sys/bus/$1/devices/$3"
        [ -d "$drvdir" -a -d "$devdir" ] || return
        echo "$3" > "$drvdir/unbind"
        echo "$3" > "$drvdir/bind"
}

rebind platform 'dw-apb-uart'   '80860F0A:00'   # BYT ttyS1 (ACPI)
rebind platform 'dw-apb-uart'   '8086228A:00'   # BSW ttyS1 (ACPI)
rebind pci      '8250_mid'      '0000:00:04.2'  # Edison ttyS1
rebind pci      'intel-lpss'    '0000:00:18.1'  # BXT LH ttyS1
rebind pci      'intel-lpss'    '0000:00:1e.0'  # SKL ttyS1
rebind pci      '8250_lpss'     '0000:00:1e.3'  # BSW ttyS1 (PCI)

-- 
With Best Regards,
Andy Shevchenko


