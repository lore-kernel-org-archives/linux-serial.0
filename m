From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH] serial: msm_serial_hs: Add MSM high speed UART driver
Date: Mon, 13 Dec 2010 11:26:26 -0800
Message-ID: <20101213192626.GA22099@huya.qualcomm.com>
References: <4CEE028B.1040701@codeaurora.org>
 <20101125170113.GB17686@kroah.com>
 <4D05C664.3030605@codeaurora.org>
 <20101213180607.GA28841@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:64498 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab0LMT0b (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Dec 2010 14:26:31 -0500
Content-Disposition: inline
In-Reply-To: <20101213180607.GA28841@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Mayank Rana <mrana@codeaurora.org>, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, npelly@google.com

On Mon, Dec 13, 2010 at 10:06:07AM -0800, Greg KH wrote:

> Yes, it's not good to clutter up include/linux/ with this kind of
> platform specific stuff.  Create a new directory and we will then move
> all of these types of files over to it, yours will be one of the first.

I like this idea.  If we agree on the directory name of
include/linux/platform_data then I'll start having people change that
as they are preparing various drivers for submission.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
