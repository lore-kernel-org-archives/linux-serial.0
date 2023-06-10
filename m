Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BD8C7EE2F
	for <linux-serial@archiver.kernel.org>; Sat, 10 Jun 2023 14:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjFJOID (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 10 Jun 2023 10:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjFJOID (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 10 Jun 2023 10:08:03 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DED3A97
        for <linux-serial@vger.kernel.org>; Sat, 10 Jun 2023 07:08:01 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 7zFvqEITSUpIF7zFvq7zo5; Sat, 10 Jun 2023 16:07:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686406074;
        bh=onZOdKuEexl0Sa+UUGGCFHHveZEuWKTGR+4o43UMOtk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cJQOUaxk3BRcXQiCiiZGOfpOEd+nbZH5RwZ1+h1QA7mZwjeSwcDwCXI82AUQYtLwe
         PpGuxq/NT4cLnr34K7NfwMAP4dW0d9tGLYP80xd7lCAmPIpQ3l1oDuJL3ftIXLiPf5
         Uv0ZORbP7vSnzqlbFmefaQUo6GSr9BiJ7lgt2xVBPf+TfEcqNKCwjOmEKzbILDeQpJ
         hpnvWKPIAYTo/ywZ9X1PSGgrGJ3EJ41lywkrtRxzm46gTeQB5snVlASc0Y70+RC+Bt
         TGeFg4sIP5XP1d8Ue9S0eZWiBhvo2RkjJ5ez/Ceq+14YDAYgrqsrYZ5Raj199HnWRt
         BTdcdcGrvwaOw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Jun 2023 16:07:54 +0200
X-ME-IP: 86.243.2.178
Message-ID: <58d3f250-499d-5a18-6798-f9833cc2dbbd@wanadoo.fr>
Date:   Sat, 10 Jun 2023 16:07:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() in case of error
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
References: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
 <20230610102607.7nonyh5xhuhpyy6e@intel.intel>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230610102607.7nonyh5xhuhpyy6e@intel.intel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Le 10/06/2023 à 12:26, Andi Shyti a écrit :
>> @@ -1459,8 +1459,10 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
>>   			continue;
>>   
>>   		rate = clk_get_rate(clk);
>> -		if (!rate)
>> +		if (!rate) {
>> +			clk_put(clk);
>>   			continue;
> 
> could you also print an error here?
> 

Is:
	dev_err(ourport->port.dev,
		"Failed to get clock rate for %s.\n", clkname);

fine for you?

CJ

