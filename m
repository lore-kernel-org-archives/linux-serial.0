From: Roman Kurakin <rik@cronyx.ru>
Subject: Re: development of serial driver (i.e. 8250_pci HOWTO)
Date: Tue, 05 Jul 2005 20:47:12 +0400
Message-ID: <42CAB990.6010901@cronyx.ru>
References: <MFEBKNPNJBEAJEICJEJNIEANCLAA.matts@commtech-fastcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hanoi.cronyx.ru ([144.206.181.53]:43715 "EHLO hanoi.cronyx.ru")
	by vger.kernel.org with ESMTP id S261932AbVGEQuf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Jul 2005 12:50:35 -0400
Received: (from root@localhost)
	by hanoi.cronyx.ru (8.13.0/vak/3.0) id j65GlPmC013689
	for linux-serial@vger.kernel.org.checked; Tue, 5 Jul 2005 20:47:25 +0400 (MSD)
	(envelope-from rik@cronyx.ru)
In-Reply-To: <MFEBKNPNJBEAJEICJEJNIEANCLAA.matts@commtech-fastcom.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: matts@commtech-fastcom.com
Cc: linux-serial@vger.kernel.org

Hi,

Matt Schulte wrote:

>>Roman Kurikin wrote:
>>You may do like Cronyx did. This probably is not the best way in general,
>>but if for device is enough a generic support and in case the driver is
>>not a part of the system (e.q. need to support different kernel branches)
>>this is I am sure the best way.
>>    
>>
>
>Roman, thank you for the suggestion.  While what you have done with your
>driver is definitely a way of getting my card installed, I would still like
>to see and example or a description of the "correct" way of going about this
>with the new serial driver.
>  
>
I suggest you to compile docbook for kernel. You may read there API 
description.

rik

>Matt Schulte
>Commtech, Inc.
>http://www.commtech-fastcom.com
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-serial" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  
>

