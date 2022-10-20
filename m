Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A2EC433FE
	for <linux-serial@archiver.kernel.org>; Thu, 20 Oct 2022 14:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJTOLA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Oct 2022 10:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiJTOK7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Oct 2022 10:10:59 -0400
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B557B111BBE
        for <linux-serial@vger.kernel.org>; Thu, 20 Oct 2022 07:10:57 -0700 (PDT)
Received: from [127.0.0.1] (87-49-146-81-mobile.dk.customer.tdc.net [87.49.146.81])
        by first.geanix.com (Postfix) with ESMTPSA id 0015757A8A;
        Thu, 20 Oct 2022 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1666275054; bh=UjEnQ9CTND4X9jz81R913jY69IPuGELZx6Pu1jdS89c=;
        h=Date:From:To:CC:Subject:In-Reply-To:References;
        b=H+Pl6EhOHaPvrJABy2VVhaQjeGF6qF46kEAtEV2xHGYJ6p2XoIOZv5SUmgUlCDgiZ
         +hIL0khNJi2DhREa0wTzIlGSAjMVGYPnZ+h0i834Sqkc1Z8gaipZjwJfocE7TDVLT2
         XP2NgJ2SPFoO+YVXMw4Qt0HcIepviVR17YVpbo844tMFpfYZARed/FKuaMSaKR9xnP
         P6JcPOxFk8SISqniegPhtvR5Rd5w4zm4IvorA+VXvEIEknNRht2ou6wZEdbwqjXg2M
         xAKDIZ/7q4vmTbj1q78JzXkScbG71dA1k+OjolnNr1hCcAmdUdsY5LKJgpyifQoB5P
         axX/N0lx6to4w==
Date:   Thu, 20 Oct 2022 16:10:53 +0200
From:   =?ISO-8859-1?Q?Martin_Hundeb=F8ll?= <martin@geanix.com>
To:     =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/3=5D_serial=3A_8250=3A_allow_?= =?US-ASCII?Q?use_of_non-runtime_configured_uart_ports?=
User-Agent: K-9 Mail for Android
In-Reply-To: <7baa90-e168-4bbe-5ce1-12c7de2ee04e@linux.intel.com>
References: <20221018133419.134110-1-martin@geanix.com> <7baa90-e168-4bbe-5ce1-12c7de2ee04e@linux.intel.com>
Message-ID: <0B4E8D8F-8E89-4951-9B5C-AFDF6667A1CC@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On October 20, 2022 2:34:14 PM GMT+02:00, "Ilpo J=C3=A4rvinen" <ilpo=2Ejar=
vinen@linux=2Eintel=2Ecom> wrote:
>On Tue, 18 Oct 2022, Martin Hundeb=C3=B8ll wrote:
>
>> The logic to find unused ports when registering new 8250 uart ports
>> searches only up to CONFIG_SERIAL_8250_RUNTIME_UART, which forces users
>> of external 8250 ports to increase the number of runtime ports
>> artificially=2E
>>=20
>> Fix this by initializing each allocated port structure with basic
>> settings like line number and uart operation callbacks, and by searchin=
g
>> the entire array of allocated ports to find an unused one=2E
>
>So nr_uarts no longer means "Maximum number of UARTs supported=2E" ?
>Perhaps it should be reworded too=2E
>

It never did=2E Confusingly, the module parameter name (nr_uarts) correspo=
nds to CONFIG_SERIAL_8250_RUNTIME_UARTS, and controls the number of built-i=
n (non-discoverable) ports=2E The other config, CONFIG_SERIAL_8250_NR_UARTS=
, controls the maximum number of ports=2E

We cannot change the module parameter name, so I'm not sure if we should m=
ap it to another static variable in the source?

// Martin
