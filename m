From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Subject: RE: [PATCH 1/2] serial:blackfin: Correct coding style in bfin
 serial driver.
Date: Tue, 19 Jul 2011 22:44:36 -0400
Message-ID: <DB904C5425BA6F4E8424B3B51A1414D16C9CB6EE64@NWD2CMBX1.ad.analog.com>
References: <1311070165-29402-1-git-send-email-sonic.adi@gmail.com>
 <1311089315.2286.157.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:40039 "EHLO
	TX2EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752433Ab1GTCpa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Jul 2011 22:45:30 -0400
In-Reply-To: <1311089315.2286.157.camel@Joe-Laptop>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Joe Perches <joe@perches.com>, Sonic Zhang <sonic.adi@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



>-----Original Message-----
>From: Joe Perches [mailto:joe@perches.com]
>Sent: Tuesday, July 19, 2011 11:29 PM
>To: Sonic Zhang
>Cc: Alan Cox; linux-serial@vger.kernel.org;
>linux-kernel@vger.kernel.org; Zhang, Sonic
>Subject: Re: [PATCH 1/2] serial:blackfin: Correct coding style
>in bfin serial driver.
>
>On Tue, 2011-07-19 at 18:09 +0800, Sonic Zhang wrote:
>> From: Sonic Zhang <sonic.zhang@analog.com>
>[]
>> @@ -1091,10 +1090,18 @@
>bfin_serial_console_get_options(struct bfin_serial_port *uart,
>int *baud,
>>                              *parity = 'o';
>>              }
>>              switch (lcr & 0x03) {
>> -                    case 0: *bits = 5; break;
>> -                    case 1: *bits = 6; break;
>> -                    case 2: *bits = 7; break;
>> -                    case 3: *bits = 8; break;
>> +            case 0:
>> +                    *bits = 5;
>> +                    break;
>> +            case 1:
>> +                    *bits = 6;
>> +                    break;
>> +            case 2:
>> +                    *bits = 7;
>> +                    break;
>> +            case 3:
>> +                    *bits = 8;
>> +                    break;
>>              }
>
>Maybe just:
>       *bits = 5 + (lcr & 3);
>

Could be a new patch.

Sonic
>
>

