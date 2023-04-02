Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204A2C76196
	for <linux-serial@archiver.kernel.org>; Sun,  2 Apr 2023 10:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjDBKsf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 2 Apr 2023 06:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjDBKse (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 2 Apr 2023 06:48:34 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC795618B
        for <linux-serial@vger.kernel.org>; Sun,  2 Apr 2023 03:48:32 -0700 (PDT)
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 332AmUo7099811;
        Sun, 2 Apr 2023 19:48:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sun, 02 Apr 2023 19:48:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 332AmUXt099807
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 2 Apr 2023 19:48:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <dfdb9da6-ca8f-7a81-bfdd-d74b4c401f11@I-love.SAKURA.ne.jp>
Date:   Sun, 2 Apr 2023 19:48:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: [PATCH] mm/page_alloc: don't check zonelist_update_seq from atomic
 allocations
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Patrick Daly <quic_pdaly@quicinc.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     syzkaller-bugs@googlegroups.com,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        syzbot <syzbot+223c7461c58c58a4cb10@syzkaller.appspotmail.com>,
        linux-mm <linux-mm@kvack.org>
References: <000000000000b21f0a05e9ec310d@google.com>
 <f6bd471c-f961-ef5e-21c5-bf158be19d12@linux.intel.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <f6bd471c-f961-ef5e-21c5-bf158be19d12@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

syzbot is reporting circular locking dependency which involves
zonelist_update_seq seqlock, for zonelist_update_seq is checked
while doing GFP_ATOMIC allocation.

Since zonelist_update_seq is checked for avoiding unnecessary OOM kill,
there is no need to check zonelist_update_seq for memory allocations
which will fail without OOM kill.

Therefore, let's keep locking dependency simple, by not checking
zonelist_update_seq from !__GFP_DIRECT_RECLAIM allocations.

Reported-by: syzbot <syzbot+223c7461c58c58a4cb10@syzkaller.appspotmail.com>
Link: https://syzkaller.appspot.com/bug?extid=223c7461c58c58a4cb10
Fixes: 3d36424b3b58 ("mm/page_alloc: fix race condition between build_all_zonelists and page allocation")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 mm/page_alloc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7136c36c5d01..80ef79b23865 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4759,17 +4759,17 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
  */
 static DEFINE_SEQLOCK(zonelist_update_seq);
 
-static unsigned int zonelist_iter_begin(void)
+static unsigned int zonelist_iter_begin(gfp_t gfp_mask)
 {
-	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
+	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE) && (gfp_mask & __GFP_DIRECT_RECLAIM))
 		return read_seqbegin(&zonelist_update_seq);
 
 	return 0;
 }
 
-static unsigned int check_retry_zonelist(unsigned int seq)
+static unsigned int check_retry_zonelist(unsigned int seq, gfp_t gfp_mask)
 {
-	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
+	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE) && (gfp_mask & __GFP_DIRECT_RECLAIM))
 		return read_seqretry(&zonelist_update_seq, seq);
 
 	return seq;
@@ -5083,7 +5083,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	no_progress_loops = 0;
 	compact_priority = DEF_COMPACT_PRIORITY;
 	cpuset_mems_cookie = read_mems_allowed_begin();
-	zonelist_iter_cookie = zonelist_iter_begin();
+	zonelist_iter_cookie = zonelist_iter_begin(gfp_mask);
 
 	/*
 	 * The fast path uses conservative alloc_flags to succeed only until
@@ -5261,7 +5261,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * a unnecessary OOM kill.
 	 */
 	if (check_retry_cpuset(cpuset_mems_cookie, ac) ||
-	    check_retry_zonelist(zonelist_iter_cookie))
+	    check_retry_zonelist(zonelist_iter_cookie, gfp_mask))
 		goto restart;
 
 	/* Reclaim has failed us, start killing things */
@@ -5287,7 +5287,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * a unnecessary OOM kill.
 	 */
 	if (check_retry_cpuset(cpuset_mems_cookie, ac) ||
-	    check_retry_zonelist(zonelist_iter_cookie))
+	    check_retry_zonelist(zonelist_iter_cookie, gfp_mask))
 		goto restart;
 
 	/*
-- 
2.34.1

