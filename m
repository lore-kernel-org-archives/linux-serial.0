From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 0/9] Blacfin Serial Driver updates for 2.6.28-rc1 (v2)
Date: Fri, 17 Oct 2008 01:43:58 +0800
Message-ID: <1224179047-13073-1-git-send-email-cooloney@kernel.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:20082 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587AbYJPRnh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Oct 2008 13:43:37 -0400
Received: by ti-out-0910.google.com with SMTP id b6so49514tic.23
        for <linux-serial@vger.kernel.org>; Thu, 16 Oct 2008 10:43:35 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org


Hi Alan,

I split out the barrier change required by Blackfin SMP like patch and
also added some new bug fixing from Sonic.

Thanks
-Bryan
