From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] serial: st-asc: Fix SysRq char handling
Date: Fri, 28 Mar 2014 10:54:51 +0000
Message-ID: <533554FB.9010506@linaro.org>
References: <1396003872-30188-1-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:62231 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbaC1Ky4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Mar 2014 06:54:56 -0400
Received: by mail-wg0-f50.google.com with SMTP id x13so3519746wgg.9
        for <linux-serial@vger.kernel.org>; Fri, 28 Mar 2014 03:54:55 -0700 (PDT)
Received: from harvey.bri.st.com (cpc4-aztw19-0-0-cust157.18-1.cable.virginm.net. [82.33.25.158])
        by mx.google.com with ESMTPSA id h5sm6007941wiy.18.2014.03.28.03.54.53
        for <linux-serial@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 28 Mar 2014 03:54:54 -0700 (PDT)
In-Reply-To: <1396003872-30188-1-git-send-email-daniel.thompson@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 28/03/14 10:51, Daniel Thompson wrote:
> This driver, like several others, uses the upper bits of the character
> to track both real and dummy state. Unfortunately it neglects to mask
> these bits properly when passing the character data around. This means
> neither break detection nor sysrq character handling work correctly.

Many apologies but I have posted this patch twice (the first send had a
grossly incomplete Cc: list).

Please ignore the this thread and use the other one.


Daniel.
