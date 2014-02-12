From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] serial: sirf: update copyright years to 2014
Date: Wed, 12 Feb 2014 22:26:32 +0800
Message-ID: <CAGsJ_4zuju7x06nvZOMKvU8xfULy5bgNTyENSfmPVNg6TcwRdQ@mail.gmail.com>
References: <1392214124-3427-1-git-send-email-21cnbao@gmail.com> <20140212141931.GA7688@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:41770 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbaBLO0x (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Feb 2014 09:26:53 -0500
Received: by mail-pd0-f181.google.com with SMTP id y10so9028463pdj.40
        for <linux-serial@vger.kernel.org>; Wed, 12 Feb 2014 06:26:52 -0800 (PST)
In-Reply-To: <20140212141931.GA7688@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Barry Song <Baohua.Song@csr.com>

2014-02-12 22:19 GMT+08:00 Greg KH <gregkh@linuxfoundation.org>:
> On Wed, Feb 12, 2014 at 10:08:44PM +0800, Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  drivers/tty/serial/sirfsoc_uart.c |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
>> index 49a2ffd..7079b5c 100644
>> --- a/drivers/tty/serial/sirfsoc_uart.c
>> +++ b/drivers/tty/serial/sirfsoc_uart.c
>> @@ -1,7 +1,8 @@
>>  /*
>>   * Driver for CSR SiRFprimaII onboard UARTs.
>>   *
>> - * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
>> + * Copyright (c) 2011 - 2014 Cambridge Silicon Radio Limited, a CSR plc group
>> + * company.
>
> I do not see contributions from csr for all of these years, so no, this
> is not allowed.  Please go talk with your corporate lawyer if you have
> questions about how/when to update the copyright of your files, as I
> don't think they would agree that this change is correct.

Greg, as i run "git log sirfsoc_uart.c", there are commits from csr
for touched file from 2011 to 2014:

2011:
commit 161e773cbd0c3d1b5b8cc00602e1f72de61ed4f7
Author: Rong Wang <Rong.Wang@csr.com>
Date:   Thu Nov 17 23:17:04 2011 +0800

2012:
commit 5425e03f97d1e5847372aae0b895d8d1c9bf2741
Author: Barry Song <Baohua.Song@csr.com>
Date:   Tue Dec 25 17:32:04 2012 +0800

2013:
commit ac4ce718893c546f7a2d34ab55a8f75842399f86
Author: Barry Song <Baohua.Song@csr.com>
Date:   Wed Jan 16 14:49:27 2013 +0800
...
commit 59f8a62c25b9c2a53e7c359ba9ca611639a4c0b0
Author: Qipan Li <Qipan.Li@csr.com>
Date:   Sat Sep 21 09:02:10 2013 +0800


2014:
commit 388faf9ffdaf92c81243514a2dd4c6ce04d28874
Author: Qipan Li <Qipan.Li@csr.com>
Date:   Fri Jan 3 15:44:07 2014 +0800

commit df8d4aa0d84995bf7fb8d8a978a0d67fff6ca53a
Author: Qipan Li <Qipan.Li@csr.com>
Date:   Fri Jan 3 15:44:08 2014 +0800

>
> greg k-h

-barry
