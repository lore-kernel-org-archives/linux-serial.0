Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48DDC77B76
	for <linux-serial@archiver.kernel.org>; Tue, 25 Apr 2023 13:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDYNAb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Apr 2023 09:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjDYNA1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Apr 2023 09:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E7313C30;
        Tue, 25 Apr 2023 06:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6850260D56;
        Tue, 25 Apr 2023 13:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8F6C43442;
        Tue, 25 Apr 2023 13:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682427625;
        bh=XO4S6eeVuuK3+SDKORRmedfITWuDoW1zGPNl7NOvUEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KtEhLdOBnurJeUJQrhRpFGl4Tgyhno3iPi3QkHG0mf7kYqcYUz0XDHj8NVORHsFjx
         cuawNStCPmhSv7qK6pr/mI1oQYw3t77Gy8g73tMUvgf+I7J3Ae+s/tqokcG2PBgBgy
         RODcFuC1A27hV1/r7wFxS6rcI72EY/QIEr7eXUNQ=
Date:   Tue, 25 Apr 2023 15:00:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Clark <james.clark@arm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net,
        michal.simek@amd.com, Jonathan.Cameron@huawei.com,
        andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v3 0/4] devres: Provide krealloc_array
Message-ID: <ZEfO5kXIBVifamC4@kroah.com>
References: <20230320145710.1120469-1-james.clark@arm.com>
 <108babe4-20cb-e637-e7da-7d04127d2a9e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <108babe4-20cb-e637-e7da-7d04127d2a9e@arm.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 25, 2023 at 01:51:31PM +0100, James Clark wrote:
> 
> 
> On 20/03/2023 14:57, James Clark wrote:
> > Changes since v2:
> >  
> >  * Remove change in qcom_geni_serial.c in the last commmit and replace
> >    it with a comment instead
> >  * Whitespace fix
> > 
> > Changes since v1:
> > 
> >  * Style fix
> > 
> > -----------------------
> > 
> > Hi,
> > 
> > I had a use for a devm realloc_array in a separate change, so I've
> > added one and updated all the obvious existing uses of it that I could
> > find. This is basically a copy paste of the one in slab.h
> > 
> > Applies to v6.3-rc3
> > 
> > Thanks
> > James
> > 
> > James Clark (4):
> >   devres: Provide krealloc_array
> >   hwmon: pmbus: Use devm_krealloc_array
> >   iio: adc: Use devm_krealloc_array
> >   serial: qcom_geni: Comment use of devm_krealloc rather than
> >     devm_krealloc_array
> > 
> >  .../driver-api/driver-model/devres.rst          |  1 +
> >  drivers/hwmon/pmbus/pmbus_core.c                |  6 +++---
> >  drivers/iio/adc/xilinx-ams.c                    |  9 +++------
> >  drivers/iio/adc/xilinx-xadc-core.c              | 17 +++++++----------
> >  drivers/tty/serial/qcom_geni_serial.c           |  5 +++++
> >  include/linux/device.h                          | 11 +++++++++++
> >  6 files changed, 30 insertions(+), 19 deletions(-)
> > 
> 
> Hi Greg,
> 
> Is it possible to take this one? Or at least the first commit?

It's the middle of the merge window, no one can take anything new,
sorry.  Please wait for -rc1 to come out and then resend.

thanks,

greg k-h
