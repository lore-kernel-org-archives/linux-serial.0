Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF373438BB;
	Fri, 17 Jul 2026 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271251; cv=pass; b=UAEdIwz9/wwEEQEvPclNHS8+EiKh4pQ2fVSfwsK5hvMhw788482x0uF2GoG7OpcNGAXYUxp6/fCp4RTWowRKzKHRjF2ngNws55CNSpahKwa6MqjOm1zY35JK4Ypa8GXFrbhTAysXrKAc3XyQScT4U7xkBOaOCB69av4o+CpQyHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271251; c=relaxed/simple;
	bh=2PmlOybW3VfZTf6u81JCqtoo0275M1CdG9Jt6WbnSZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHqzxq9omoML3d8t16juWQs8qKVcLwBrRkwVhweF/aypMpWxT6EORyW+WSSa+8T/CjC04QZODCIVE4NIZBqjLM1EjBD/DOWdYCA+9STAohEGgVyxbZWMPltjk63v9ECT4Bwy8oWReo7L+wDGu1teu5O8hERY43q2qtt9LWFMi08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sPdVD19/; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=+IoWEPO3; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sPdVD19/";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="+IoWEPO3"
ARC-Seal: i=1; a=rsa-sha256; t=1784271058; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Dh9S1Qq4nACZNj6Npjw82vetEvWb3trMxrlPDW5vPE55WcPkR9DYo6vuQuShGrEgyk
    FGoLugiB2G4x9Qql6gLzMENyY8EWXkwRBctO0sDg0jhJBqIWh6AP94csylSYXuWmtZlS
    CGx+uB3vGxGJgGJZ/wYsbajiLUDdX+59UU6OvJ8/x3ikUab9cpEoOVs/83Xoa6Xo7PrS
    V7wKfFsmFREbg4VyhUF6xN8X/FzMFmr++v4mvtvX9mM9+zTcDAO2xSelOIuv5IC84YWw
    X34ZN6gyUA30sX0r6VZ4+26Yn+NgY0D73LnYGDSLAUS1L/x6gKt9JMSkQvB3vR7SgdCZ
    9W3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784271058;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZXf+a4kYu3/g6axU2DMWLRarZagNiTvcRnNPWRuNmE8=;
    b=FIb3c0mTZ+iWdFWjoSKfahRD0NcxAcMl+l6t/aGQweNZaNnRF48QpXPA6y1gp4RMXB
    PNj+jkTKh6k1v9sVNNWCwTCedCsuopvKxL6iNmeAR1rWPxdz8qFic7czlzw0nXJqjRCm
    8AWdKTlzX5r0gzw0cXAWOaYfTeWOItuh+gHKmYx6XF5K4FLqguK+OPfx4PjLpHxoTaNs
    x4+YqQd/15rDEpGK16Nw0Q/8XJ4IhVbtlGnOqv8tP/y0CM4REMVyEBgbnC/rjnaAPR4g
    bHWKpJ+puv92bfEAU8Jl37bag/+weH4FN4ripEbE94lyC+l7maiYH6MuqqpdcCyQOSDH
    hi3Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784271058;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZXf+a4kYu3/g6axU2DMWLRarZagNiTvcRnNPWRuNmE8=;
    b=sPdVD19/kDGx2Tt9ELvqRZvTbr22FoeaLZFRD9r8XdjV7ffO8mZeaRLA2/MMXWnVWR
    dYVEFVvD1hcMA+Id9WAi9khoE7LvIWFdorNedXn1hy1uGdx80ocf7UmyEU5jVhzGdykf
    gnRtxCPUb6FqS0P5fFH3BHNK6bCA9///h/XQZVo5ow0hdKbyq/ReAxIbFMvmXkvj0IPI
    +6IRxR876rEp60Z0unpsLUngtYguUbPuCWCE6QagDJBkTylgpn6IE+gzG6iRzAPa7XPe
    6b3FaY1XhjM3pueD6yr9qG6owLghQKGY0e4hEuKvdEO2RlL1yRvnaaD3kb9DnYBcG60y
    4A7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784271058;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZXf+a4kYu3/g6axU2DMWLRarZagNiTvcRnNPWRuNmE8=;
    b=+IoWEPO300wU5Kjg/UcLiHyJmUK9yBQ1KQa+B5hXCZ76VEiS9SdbUuWAlVaOCIDup1
    Af65EF3y2S78bVwpcRCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.147]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26H6osL6V
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 17 Jul 2026 08:50:54 +0200 (CEST)
Message-ID: <4f1e340c-2abb-4e1d-bb10-7a6d88ddb6fa@hartkopp.net>
Date: Fri, 17 Jul 2026 08:50:49 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: ldisc: fix deadlock between ldisc_sem and rtnl_mutex
To: "Zhou, Yun" <yun.zhou@windriver.com>,
 "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "jirislaby@kernel.org" <jirislaby@kernel.org>, sdf.kernel@gmail.com
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "mkl@pengutronix.de" <mkl@pengutronix.de>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260716064719.1401892-1-yun.zhou@windriver.com>
 <PH0PR11MB5902C0DC3D8407F2701948C1F0C72@PH0PR11MB5902.namprd11.prod.outlook.com>
 <70f854e7-b066-4f30-8ebf-71abdece45c2@windriver.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <70f854e7-b066-4f30-8ebf-71abdece45c2@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


>>>
>>> +      /*
>>
>> this blank line is redundant i believe
>>
> 
> Isn't it common practice to leave the first line of a multi-line comment 
> blank? Does it violate the coding style guidelines?
> 

You are right.

The non-blank first comment line is only common for networking but you 
posted a patch for the tty subsystem and not for networking.

Documentation/Codingstyle explains that:

     The preferred style for long (multi-line) comments is:

         /*
          * This is the preferred style for multi-line
          * comments in the Linux kernel source code.
          * Please use it consistently.
          *
          * Description:  A column of asterisks on the left side,
          * with beginning and ending almost-blank lines.
          */

     For files in net/ and drivers/net/ the preferred style for long 
(multi-line)
     comments is a little different.

         /* The preferred comment style for files in net/ and drivers/net
          * looks like this.
          *
          * It is nearly the same as the generally preferred comment style,
          * but there is no initial almost-blank line.
          */

Source: https://lwn.net/Articles/694755/

Best regards,
Oliver

