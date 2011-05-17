From: Pavan Savoy <pavan_savoy@sify.com>
Subject: scheduling work from receive_buf
Date: Tue, 17 May 2011 20:50:09 +0530
Message-ID: <BANLkTiniE1zcvW0CPJF3KRJ8XV03fKwNiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36220 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755225Ab1EQPUK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 May 2011 11:20:10 -0400
Received: by wwa36 with SMTP id 36so673861wwa.1
        for <linux-serial@vger.kernel.org>; Tue, 17 May 2011 08:20:09 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

currently in my line discipline driver - I've implemented a
receive_buf function inside which upon receiving a particular byte of
data, I need to
send a bunch of data and wait for its reception (which happens to
accumulate in receive_buf).

for this I implemented a work struct which I schedule into the default
work queue by doing a schedule_work inside my receive_buf function
when I receive such byte.
However I can't seem to do a wait_for_completion inside my work
handler. This completion is completed upon reception inside the
receive_buf function.

wait_for_completion inside the worker thread doesn't seem to allow the
receive_buf to be called.
Please suggest how best I can implement something like this ?
