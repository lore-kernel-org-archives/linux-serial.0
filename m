Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9C7EEAA6A
	for <linux-serial@archiver.kernel.org>; Thu, 14 Sep 2023 19:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbjINTvm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Sep 2023 15:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240956AbjINTvj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Sep 2023 15:51:39 -0400
Received: from DM4PR02CU001.outbound.protection.outlook.com (mail-centralusazon11012012.outbound.protection.outlook.com [52.101.63.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382B926BC
        for <linux-serial@vger.kernel.org>; Thu, 14 Sep 2023 12:51:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ji37ixhYJ+I+BRQQu7e1KMclTywiVGEcnsNk+ligHYtHUhKyfuBA60azaKTVB1divH+1cXY5kOWheHC/dDeiy8pvpDANTeykGI45qVo5vEvP5aEhQKNdQCbowg8Ea5YSPlP0r0zJ2Aa/qlbQkrKpZZ2LSil8bHnXDMyvW+80PZ72F+KYVamyzT4UrqJopHYFz5+BmipX4zSaYjaJBWR9NLLTeZ4gHby/JzcPfjNTUG1EWA1fe3mrqtKpCzJqzBLMNtWz/qsIJKJW6imlKpyE98YvPy/OaVDx8dSE5A6b5ttimtVr2sJAcQwdCi+wO48sxMGBirhQrIKr9bcWp0Am3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fabrTkUpMBwLar5NhjTNVwnsDy3iKRFATOjtqPmZi4=;
 b=PMpwnuz4nGJ/U4TX9JSQ+Dp8Pb+FPJ8bBDohmoBSTsEovrl7g4eQ0rx9wkv6BstspH4c9VwPGpQRz1dF4vHiqmAhRBCoraBbwiZDftY5emMc5tgTOnoWxFhBeDMy6eHk26kfk776QsfbXwaxJq+XT/HIeUUj5qpxMK2hwf1UWdbg2c/9P0eYdjV1SeKeagyHBeqRFYZXEUCjEObQPSF6WHa+CUwFKmXObuyMnr8i6F3uoxK8H9uIQeOzs4HoA1HEQtCz3FonE04MqTZxttLW/kgxmotfPOFyg2E2BlDVYQYmjYlGzB7rhQ6YsaUpajkMU/5lxMhwCrboZ3gYFI+4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fabrTkUpMBwLar5NhjTNVwnsDy3iKRFATOjtqPmZi4=;
 b=Gn5zMEzFlORlcXs77OZUWl2BTlmT42WeuwWcEUtRkp/kdpssLMMcKwYmhu+1GcyQYtd+p/UrJevpr784Od5QuFREf85R/n2FEt87DYd0gXjDKVbiwdnJLBUJIU4W2zcPOsy5OVEVGtf0q3yKfu2GSJA9JyQ3BS2AXMNOEQ2KjgP+pDYkO+dJfdW4ScBjhAaC/U4krtzAGR+ceWVRlO0uy1UbOVfJk86M6Skvxe2WX9q5zayCk2MwKfQtBlD8K0QgNxxYdIe3UW18DnXxazpSqYSt/tqWTToBHhnfnymbM514pS6lhMICiaMfP9VSMklBU9fbT70Vks4annxyay7hAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by CO6PR05MB7588.namprd05.prod.outlook.com (2603:10b6:5:349::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Thu, 14 Sep
 2023 19:51:32 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 19:51:32 +0000
Date:   Thu, 14 Sep 2023 15:51:26 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
cc:     Matthew Howell <matthew.howell@sealevel.com>,
        gregkh@linuxfoundation.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, linux-serial@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V5 1/2] serial: exar: Revert "serial: exar: Add support
 for Sealevel 7xxxC serial cards"
In-Reply-To: <ZQNZJwJoad0EkIYL@smile.fi.intel.com>
Message-ID: <15c38a1b-65ed-54db-c973-0ae995e201d4@sealevel.com>
References: <a804d136-4865-f528-6434-68a7358d7606@sealevel.com> <ZQNZJwJoad0EkIYL@smile.fi.intel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN0PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:408:e4::19) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|CO6PR05MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5504ea-d7ae-4ccd-9037-08dbb55bfeb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAxjrItpknGuZBCxPcIsXQ4RiWTgBmxg/YVscECO90N1RpL6BXSuaYwKJZaO1hIm61c912vH5mAF1/piMRsjMjO2H1bdVjU/1vfR10sggwhNMDjWDe0NlrAJqo0Q6jxGpYquHkgsZu5JmyDS+JAt+RRo9a2sj8/rNaAP3Pe60rkPtPzeuyn1cNW4k3l2OJsSZWlCwVT6ID4VwXIOMXeCRlZwE4n2MJoNe61OHaKertX3SxFeIZdWQbwwl/qBBgQD7Ro/anfuD8FmJE7cIrL3Hoes0IYp5ZqYFGd8+/d/C/zjO6yv1HXR/XudGnIptCgy2jdLRqavbcmQVtwTtVIBUqZLUp8/MYmqXlJQbgmjTbBByMIZdN6hNyNoGpYuyp6IBLXvOUqOg3Y1EVSJ1LRoLliV5SvFzdbafFQnXHsq+gY30fHXpTzcJ4t+x3XXa7XRKo2nxMytokbv7WMsTaQSOnJuXnFI/PlUb4tTBkoNVZp1TajtDAlYgqoKqZqN+XJICqqeuymB5W+w6lThdQriHhFYBEZcjvuvfhEUqme85z7nenj4VDAC+5cfDKGsyC1f4/OTAze6ljoC/w6bDX+5p6igKKKFZIM7vEnbAI1+Zwhe7vXJV5sk5JWtq/0ozwZCOttfg9tiRGf/DZrxjwElSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39840400004)(396003)(376002)(136003)(346002)(451199024)(186009)(1800799009)(36756003)(31696002)(86362001)(38100700002)(31686004)(44832011)(6486002)(478600001)(5660300002)(66476007)(6506007)(66556008)(6666004)(8676002)(8936002)(4326008)(2906002)(66946007)(966005)(6512007)(316002)(26005)(6916009)(41300700001)(2616005)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o2kCDJQR11bdQkqs3tfKEOPc//Vl4UVATZ9B997627i3e86zhIYpNGcH9efE?=
 =?us-ascii?Q?83MoV1F9G12PLr7pMbaaiThjjMSodQofiFzBopTUNA0hb2WXX/PbnJkvpadh?=
 =?us-ascii?Q?lqxhna8QlkycVZgxYQwbOt6y++mV7SuaXX7ad5wXPwc0IGsNJZZno752EQqJ?=
 =?us-ascii?Q?NKIJrQDPFyViwncQwmC197Fg7sejaD9rqVHXYUYpjCCdF3FdzwkQriWqDFJV?=
 =?us-ascii?Q?JR1sIeCsSnRorLpHwbaMQ0WtjzdDBRUE11Z7XP2kod6LtUy9sfFttsBobjtG?=
 =?us-ascii?Q?6SB4G7Q4nYN3PBQ0oe+ScYvIpSJbsZasnnvCDXN93Xy7j+Xf0JWXDflcQBmD?=
 =?us-ascii?Q?52fjHBVjUaxRRhyT0rRxbM2kgNy/+qmSjKszXc/rPKWellOa13F1y/EAlC3/?=
 =?us-ascii?Q?MFL3p9yFDUyIEASCYxWPh8GmGygPy/UCJHW485P1KSYZM+iEIzycA1va77xd?=
 =?us-ascii?Q?PbaBVG+fn22dE/GWuC0ZVtcEn9AiwtXk+cgq6vNhvyQ0yeL+8FmDgFnytsJD?=
 =?us-ascii?Q?7PO9hux+wdYbk+jEwgW2cj5Sv23L0Ho3KgVJU7LVgae+43Xw2Pf9+MzKcOIU?=
 =?us-ascii?Q?ndTsBCgqYV5LrlBbcMf7aOpCyjErwrZM5q3wi7YGv2Ka9xTzeui5NES8G+TR?=
 =?us-ascii?Q?+U5p+UiBqA/zYE9MMojNXzphKVxfVzXVL9XQeO7fhPqZyzLtMqF1Q1Rvbxzk?=
 =?us-ascii?Q?DWX5kQk6V7qMVmJTjLlwUXBZGGFDWPcNQF/Rtn/BZsIMZUxlJHDKAE5aRf3o?=
 =?us-ascii?Q?TXxeE1+m6PEh25ERZONLYGWEbxoRjW3QszOyQyCmFqgTmjoreGL+DAfdQ3L7?=
 =?us-ascii?Q?Sl7lEqOOyLIUB/Xd+tF0nM9fnAxi1x/PN3zvecBglu55Z6sKPKWpS3Kr9SkA?=
 =?us-ascii?Q?8eBTxFjacBhOPSaPZCZEaePua1LH9DlGBrAiopMRkDFYrl0jObrrlvbw2K5a?=
 =?us-ascii?Q?LupAfeMrDLRvZHNNQuP8Y9hD9/r+IBMrhrpMSSN5yr3egrSgPn851dxwxrJg?=
 =?us-ascii?Q?s8Ss6QWHXppNucL0Uq9dXEyrIMk7bs9b+iGX9epkfv5G1kD4qheot/T5L4Ui?=
 =?us-ascii?Q?0tYrxcVeUVvaDq/IELAv/la4h1MWqed8nyZBKAxKRSUBzbTIKKvhRPcUG6US?=
 =?us-ascii?Q?064t9Nmh4fddd4eh/uAGnd+PYu36CKgw7xCWfD9reedtQZN4wm4++oi9gLGK?=
 =?us-ascii?Q?+DV620IOZhGWR6h7n/r5bsRFkROiBFhMbqRrGBhNBxh+x+BAtV8w4EKIyVAi?=
 =?us-ascii?Q?dhDuqRl1O21itoFz1y5OCOTdF1hv2JSb44TRjbh7GS7sUuB0wm7wm5IB6ZsF?=
 =?us-ascii?Q?4T3/BDYJ8vlWbBTb+x/ASbsh7cj6YANkvIJUzS7TR1khbwisbMehKHlyliDg?=
 =?us-ascii?Q?kYWpeZplTqfo2e4dCKDr9Ff/8HU9K5TBWZA8zFsddWuVkytRs5pJNDACC2WN?=
 =?us-ascii?Q?3fYvnazFFv7RqRTkSpUpGtty54YYMfi2W6Nw+mWv7fOwAO+E3UaDXlCsnrPi?=
 =?us-ascii?Q?oVbK2DUJaA9dSXx1fqo3HALQfDRoMJ2MYN9dfnXEAYpFA3CLZlH3D/XgKX5K?=
 =?us-ascii?Q?ayWqemoflPpg7W1QtZBU9VBTjIQbI/aApCrdQgzmLn5jMJNoGJGl1jy0BBqz?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5504ea-d7ae-4ccd-9037-08dbb55bfeb8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 19:51:32.4428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbnmNiBjNwcZDbrtG1juFDWPi4vMeF66zmvOF0yqLbo0QUa2Gg4Rz/CzV1v7lWhB9/RjzhCTJgQFBD0aPGdvyFQMlG64oHWSr4KCK/OBkPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR05MB7588
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 14 Sep 2023, Andy Shevchenko wrote:
> On Thu, Sep 14, 2023 at 08:28:47AM -0400, Matthew Howell wrote:
> > From: Matthew Howell <matthew.howell@sealevel.com>
> >
> > Hardware ID of Sealevel 7xxxC cards changed prior to release. This has rendered 14ee78d5932a redundant.
> 
> Too long line.
> 
> > Revert "serial: exar: Add support for Sealevel 7xxxC serial cards"
> >
> > This reverts commit 14ee78d5932afeb710c8305196a676a715bfdea8.
> >
> > Link: https://lore.kernel.org/all/72b3e74e-ced6-784c-01e0-8a851326a203@sealevel.com/T/
> > Fixes: 14ee78d5932a ("Add support for Sealevel 7xxxC serial cards")
> > Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> 
> The patch 1 and patch 2 have not been linked via email, so mail archives and
> mail clients do not see this as a thread. I suggest to use `git send-email` for
> patches. With --thread option (which I believe should be default) it chains
> the mails it sends.

I have not seen any way to setup git send-mail with this email as git 
send-email seems to lack OAUTH2. If you can set it up with OAUTH2 & O365  
I have not been able to find any documentation or guides on how to do 
this.

> --
> With Best Regards,
> Andy Shevchenko 
 
