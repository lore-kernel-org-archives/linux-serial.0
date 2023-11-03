Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBA2C4332F
	for <linux-serial@archiver.kernel.org>; Fri,  3 Nov 2023 08:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbjKCIIU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Nov 2023 04:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjKCIIU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Nov 2023 04:08:20 -0400
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D741A8
        for <linux-serial@vger.kernel.org>; Fri,  3 Nov 2023 01:08:13 -0700 (PDT)
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by connect.vanmierlo.com (Kerio Connect 10.0.2 patch 1) with ESMTPA;
        Fri, 3 Nov 2023 09:08:08 +0100
MIME-Version: 1.0
Date:   Fri, 03 Nov 2023 09:08:08 +0100
From:   m.brock@vanmierlo.com
To:     linux-serial@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        VAMSHI GAJJELA <vamshigajjela@google.com>
Subject: Re: tldp serial-howto subscribe link
In-Reply-To: <2023110336-antiviral-gooey-91c5@gregkh>
References: <b20a6176a3c83d2ac5bb708f458e7b89@vanmierlo.com>
 <2023110336-antiviral-gooey-91c5@gregkh>
Message-ID: <4abb60ed10ae8cf64e4a1b51c5d7e8d2@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Greg KH schreef op 2023-11-03 06:39:
> On Thu, Nov 02, 2023 at 06:00:29PM +0100, m.brock@vanmierlo.com wrote:
>> Hello,
>> 
>> On the TLDP Serial HOWTO page 22.4 Serial Mailing List it says to mail 
>> to
>> majordomo@vger.kernel.org to subscribe.
>> However the link behind the visible text links to 
>> majordomo@vger.rutgers.edu
>> This looks very dodgy to me.
>> https://tldp.org/HOWTO/Serial-HOWTO-22.html
> 
> Please submit a change to the TLDP author, nothing we can do about it,
> sorry.

OK, I will.

The obvious question remains:
To subscribe one does have to mail to majordomo@vger.kernel.org, right?

And also to unsubscribe. I was hoping this was documented somewhere but 
it
appears the obvious place is tainted.

Maarten

