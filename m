Return-Path: <SRS0=DW7M=6V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC41C38A24
	for <linux-serial@archiver.kernel.org>; Thu,  7 May 2020 15:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4BE820838
	for <linux-serial@archiver.kernel.org>; Thu,  7 May 2020 15:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588865683;
	bh=su42LeOpkqoZ9FpxsWpq/u+jVkw8iFswKLvseMb3xkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YTjtcwb/1+uN7mV3pPY+mPI5HnNSqLCINZfXBYaqdyxucJzWOcqmTqs1fhZYh89Gs
	 XHa599kku+LbaFi+0OKDKF9TuLx4hqt+LmKjaE//uk9JDyTB4SgtXsNObQYC33Mwhc
	 DBHSU4cFqI5CZGHnHbR3nsagacyw41NoXCNWGkm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEGPen (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 May 2020 11:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgEGPen (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 May 2020 11:34:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42CE6207DD;
        Thu,  7 May 2020 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588865681;
        bh=su42LeOpkqoZ9FpxsWpq/u+jVkw8iFswKLvseMb3xkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MqGpj3R284gvc+wtAR2/E8G9RRNEz2VSI1EmoFaWXTzSSeWiZDJdSZcqH/orgGZNM
         3pkvM6V9zWFMFBzg4693wAFXpMM2ctlEy2EsbY5B+vZJw8t6/fpY7TJ9244gxU6VEc
         Fb+U+CjMoscYeEsuPnqsNI5TqcV6qAG9GVikqy+w=
Date:   Thu, 7 May 2020 17:34:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Subject: Re: [PATCH v3 0/2] Add CTS/RTS gpio support to STM32 UART
Message-ID: <20200507153439.GA1919950@kroah.com>
References: <20200420170204.24541-1-mani@kernel.org>
 <20200507140750.GA2019@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507140750.GA2019@Mani-XPS-13-9360>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 07, 2020 at 07:37:50PM +0530, Manivannan Sadhasivam wrote:
> Hi Greg,
> 
> On Mon, Apr 20, 2020 at 10:32:02PM +0530, mani@kernel.org wrote:
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > 
> > Hello,
> > 
> > This patchset adds CTS/RTS gpio support to STM32 UART controller.
> > Eventhough the UART controller supports using dedicated CTS/RTS gpios,
> > sometimes we need to use different set of gpios for flow control.
> > 
> > This is necessary for the upcoming STM32MP1 based board called Stinger96
> > IoT-Box. On that board, a bluetooth chip is connected to one of the UART
> > controller but the CTS/RTS lines got swapped mistakenly. So this patchset
> > serves as a workaround for that hardware bug and also supports the
> > usecase of using any gpio for CTS/RTS functionality. As per the sugggestion
> > provided by Andy for v1, I've now switched to mctrl_gpio driver.
> > 
> > This patchset has been validated with Stinger96 IoT-Box connected to Murata
> > WiFi-BT combo chip.
> > 
> 
> Are you planning to take this series for 5.8?

I had to wait for the DT protion to be reviewed before I could do
anything.  Give me some time, if it looks ok, it will go into 5.8.

thanks,

greg k-h
