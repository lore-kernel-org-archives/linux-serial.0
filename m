From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH 2/7] UART: OMAP: Cut the clock in the error cases
Date: Wed, 18 Apr 2012 20:43:40 +0530
Message-ID: <4F8EDA24.5020209@ti.com>
References: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com> <1334588821-5224-3-git-send-email-shubhrajyoti@ti.com> <87bomprjic.fsf@ti.com> <4F8E62D2.9080206@ti.com> <87bompp2bk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:56379 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753841Ab2DRPNt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 18 Apr 2012 11:13:49 -0400
Received: by pbcuo5 with SMTP id uo5so9362584pbc.32
        for <linux-serial@vger.kernel.org>; Wed, 18 Apr 2012 08:13:48 -0700 (PDT)
In-Reply-To: <87bompp2bk.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, "Govindraj.R" <govindraj.raja@ti.com>

On Wednesday 18 April 2012 07:30 PM, Kevin Hilman wrote:
>>>> >>>  		if (ret < 0) {
>>>> >>>  			serial_omap_enable_ier_thri(up);
>>>> >>> +			pm_runtime_mark_last_busy(&up->pdev->dev);
>>>> >>> +			pm_runtime_put_autosuspend(&up->pdev->dev);
>>> >> Why the autosuspend version here?
>>> >>
>>> >> Kevin
>>> >>
>>> >>
>> > In case the request_dma fails we enable the thri( effectively like intr
>> > mode) so
>> > I thought of using the autosuspend version here .
>> >
>> > Do you prefer put version instead ?
> Not necessarily, it should just be well described in the changelog.
>
> Kevin
Yes agree completely. Will describe that in the changelog.
