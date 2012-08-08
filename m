From: Stanislav Kozina <skozina@redhat.com>
Subject: Re: Patch for panic in n_tty_read()
Date: Wed, 08 Aug 2012 16:32:27 +0200
Message-ID: <5022787B.8030700@redhat.com>
References: <4FE886C6.7090606@redhat.com> <20120626152159.2a34dcaf@pyramind.ukuu.org.uk> <50094C8E.5010308@redhat.com> <20120720161123.58fc9703@pyramind.ukuu.org.uk> <50221C30.20607@redhat.com> <20120808100019.6ca011a9@pyramind.ukuu.org.uk> <502256E8.5040300@redhat.com> <20120808132643.6aa36a93@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58503 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755330Ab2HHOci (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Aug 2012 10:32:38 -0400
In-Reply-To: <20120808132643.6aa36a93@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Alan,

Thanks.
We realized that the lock is not being unlocked:-/ That's why I sent a 
V2 patch.

My apologizes,
-Stanislav

> On Wed, 08 Aug 2012 14:09:12 +0200
> Stanislav Kozina<skozina@redhat.com>  wrote:
>
>> Alan,
>>
>> Thanks a lot. So can you integrate the patch in next patchset?
> Will do - I need to resend the patch queue to Greg so I'll add it before
> that.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

