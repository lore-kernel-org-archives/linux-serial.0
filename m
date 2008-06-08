From: RuoMu Hu <huruomu@gmail.com>
Subject: Create proc entry under /proc/sys/kernel
Date: Sun, 08 Jun 2008 16:00:57 +0800
Message-ID: <484B91B9.5060204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:20006 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbYFHIBC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 8 Jun 2008 04:01:02 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2115360rvb.1
        for <linux-serial@vger.kernel.org>; Sun, 08 Jun 2008 01:01:02 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-net@vger.kernel.org

Hi!

Is it possible to create a proc entry under /proc/sys/kernel directly by 
create_proc_read_entry in the way shown below?

test_pde = create_proc_read_entry("/proc/sys/kernel/test", 0, NULL,
                                    test_read_proc, NULL);
if (test_pde == NULL) {
    printk(KERN_ERR "Failed to create the test proc file.\n");
    return -ENOMEM;
}

I'm using this in my kernel module but create_proc_read_entry always 
returns fail, while there's no problem creating proc entries directly 
under /proc.  The kernel source I'm building my kernel module against is 
2.6.25.4.

Any idea?


Thanks
Romu
