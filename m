From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH 0/7] 3.8-rc regression with pps-ldisc due to 70ece7a731
Date: 9 Feb 2013 02:05:58 -0500
Message-ID: <20130209070558.4322.qmail@science.horizon.com>
References: <20130208233656.GA7700@kroah.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:33346 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751899Ab3BIHGA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 9 Feb 2013 02:06:00 -0500
In-Reply-To: <20130208233656.GA7700@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux@horizon.com
Cc: giometti@linux.it, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, peter@hurleysoftware.com

As a followup, testing my fixes has revealed an old bug in the
PPS driver that I'm trying to figure out how to solve.

Basically, pps_unregister_cdev does

        device_destroy(pps_class, pps->dev->devt);
        cdev_del(&pps->cdev);

And device_destroy ends up calling pps->dev->release,
which is pps_device_destruct, which does

        mutex_lock(&pps_idr_lock);
        idr_remove(&pps_idr, pps->id);
        mutex_unlock(&pps_idr_lock);

        kfree(dev);
        kfree(pps);

Now the problem is that the kfree(pps) happens *before* the
cdev_del(&pps->cdev) call, which is Not Good.

I'm trying to figure out The Right Thing to do in this case and include a
fix for that, too.  It's not a regression, but it is a fairly serious bug.

Advice gratefully received, but I'll figure it out on my own, if not.
The most obvious kludge is to wrap the pps_unregister_cdev operations
in device_get/device_put, to force the release callback to be delayed
until later.

I'm hoping for something prettier, though.  The other option I'm thinking
about is to move one or both deallocations to the (currently stub)
pps_cdev_release function.
