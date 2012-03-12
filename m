From: covici@ccs.covici.com
Subject: TTY: speakup, do not use serialP
Date: Mon, 12 Mar 2012 18:59:19 -0400
Message-ID: <16455.1331593159@ccs.covici.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from s-out-001.smtp25.com ([67.228.91.90]:60297 "EHLO
	s-out-001.smtp25.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab2CMAAS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Mar 2012 20:00:18 -0400
Received: from ccs.covici.com (pool-96-247-198-116.clppva.fios.verizon.net [96.247.198.116])
	by s-out-001.smtp25.com (8.14.2/8.14.2) with ESMTP id q2CMxN4W010728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Mon, 12 Mar 2012 18:59:23 -0400
Received: from ccs.covici.com (localhost [127.0.0.1])
	by ccs.covici.com (8.14.5/8.14.4) with ESMTP id q2CMxJL4016456
	for <linux-serial@vger.kernel.org>; Mon, 12 Mar 2012 18:59:22 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi.  I read the patch with the above name, and although it may be
necessary because the structures are going away, it does not solve the
problem of getting a -16 error code when releasing a port held by the
serial drivers.  If I am correct about this, how can I fix this problem
-- if not please enlighten me as to how to release the region?

Thanks in advance for any suggestions.

-- 
Your life is like a penny.  You're going to lose it.  The question is:
How do
you spend it?

         John Covici
         covici@ccs.covici.com
