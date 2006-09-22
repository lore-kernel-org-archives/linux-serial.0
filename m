From: "Irfan Khan" <irfan.f.khan@gmail.com>
Subject: Serial Driver
Date: Fri, 22 Sep 2006 13:01:42 +0530
Message-ID: <e67aee670609220031o311444d3j8c736d4835c86f59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:13599 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750838AbWIVHbo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Sep 2006 03:31:44 -0400
Received: by nf-out-0910.google.com with SMTP id x37so1048448nfc
        for <linux-serial@vger.kernel.org>; Fri, 22 Sep 2006 00:31:43 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi Everyone,
I am writing a serial driver, which acually not handle any device,
simulate the same.
here I am getting problem like when I call write from user space it is
getting called and write function getting the data , now in write
itself I am calling  tty_insert_flip_char and tty_flip_buffer_push to
echo the string.
but when I call read  from the user space it returns EAGAIN.
Any clues/pointer would be great help.

TIA
Irfan
