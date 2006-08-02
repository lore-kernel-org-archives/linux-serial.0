From: Aubrey <aubreylee@gmail.com>
Subject: Newest Serial core issue
Date: Wed, 2 Aug 2006 15:24:03 +0800
Message-ID: <6d6a94c50608020024n9d8fbc0tcdedcadeedd54b44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:31094 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751319AbWHBHYF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Aug 2006 03:24:05 -0400
Received: by nf-out-0910.google.com with SMTP id o25so543620nfa
        for <linux-serial@vger.kernel.org>; Wed, 02 Aug 2006 00:24:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Hi all,

My platform is using DMA to tx/rx data from UART. It's ok for tx
datapath when I port the driver to the newest serial core framework.
But I found all of the current existing drivers are using
"uart_insert_char" to process the received chars to the high level tty
driver, that means the received chars are processed byte by byte. But
for my case, I need to transfer the received data to the high level
tty driver block by block. Did I miss some API like
"uart_insert_block"?
Or Are there any other way to deal with my case to use the newest serial core?

Thanks for any hints.

Regards,
-Aubrey
