Return-Path: <SRS0=2C4M=7Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88268C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 12 Jun 2020 15:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5505B20835
	for <linux-serial@archiver.kernel.org>; Fri, 12 Jun 2020 15:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591975881;
	bh=d9swAF1lBTUQKkD5upsXh8wG4RhL83NxrON4es3zSVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l8q3Gtc2NYFLYBkfltYSUnn/tnmZ0Hgkqk+qNuipCavUUb21rkx1uPfjzaCJ1ee0e
	 bD+zw9obLHyNMGFkfR/zQG724aasaoYs6Qi/J2Rol9Wa38zt6wTeb5X9CT4UXPWwYm
	 dGZuBY9i10UEYEPKgxgdNJVuqoHrJfi5D5k8N6qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgFLPbV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:31:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43869 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLPbU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Jun 2020 11:31:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id n24so11502084lji.10;
        Fri, 12 Jun 2020 08:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uQ85dD+vKUnEGdAVOTFoEvlnzXCa2uFEesLCGgB0kCQ=;
        b=WpEqnePT3wbb9MbpWk/aeLPp31mIZJeYeexehHNriKxgc59eOJEA1yYPmM+IRtapZz
         oMAdbPdWwgPzLxIkbgbpP4slQmdsJMnrUPkPIWwKGyDTOZqP/MmMbDmvS8QCw8Qn7DPi
         sf6ZbiCk2w+Xpl4oTN1NsM1yO6HV2m/i30u9v72/LwLeWc6yaG3S2bZABIyKWUoK/EOt
         Pq6xzrGXClAMs3Qz+1an+ao1gqw10R7iqWm4SgSMIK9wAOK4MhPJqiVpWK5GY4c5KCt5
         +e/zXPnpRjeFFd2LBe9EHhdqcqhB2QXV7k9TQijJ4LzEpbvOeWPvJZ500y/mk3gz88rq
         ecUA==
X-Gm-Message-State: AOAM531Xn9W0ylNliNpmcetvdI+K6HPwrjpDERZmxtGzGUK6ODXQ+tec
        1MlIC87IT+L2fhDtnwRs0Eo=
X-Google-Smtp-Source: ABdhPJwWMr52gFX6uBnkI/KD9R+p2DM9xpdSQRmup0YZVLc1Ow5T944W2VM9Akv2DEpG4aYIFx2veg==
X-Received: by 2002:a2e:a495:: with SMTP id h21mr7296320lji.436.1591975878090;
        Fri, 12 Jun 2020 08:31:18 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id v28sm1750024ljv.40.2020.06.12.08.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 08:31:17 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jjleH-0002pF-La; Fri, 12 Jun 2020 17:31:17 +0200
Date:   Fri, 12 Jun 2020 17:31:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] serial: core: fix up sysrq regressions
Message-ID: <20200612153117.GQ19480@localhost>
References: <20200610152232.16925-1-johan@kernel.org>
 <20200610162134.GL2428291@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610162134.GL2428291@smile.fi.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 10, 2020 at 07:21:34PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 10, 2020 at 05:22:29PM +0200, Johan Hovold wrote:
> > This series fixes a few regressions introduced by the recent sysrq
> > rework that went into 5.6.
> > 
> > The fix for the unnecessary per-character overhead probably could have
> > been marked for stable but I left that decision to the maintainers as it
> > is a bit intrusive (although mostly shuffling code around).
> 
> I see a problem, thanks for pointing out!
> The fix LGTM! FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for reviewing, Andy.

Johan
