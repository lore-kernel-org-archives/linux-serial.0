Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0609710D
	for <linux-serial@vger.kernel.org>; Fri,  1 Dec 2023 05:08:26 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=1713ffb560=fe@dev.tdt.de>)
	id 1r93Fo-00DYZf-W0
	for linux-serial@vger.kernel.org; Fri, 01 Dec 2023 14:08:25 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1r93Fo-00GawQ-KM
	for linux-serial@vger.kernel.org; Fri, 01 Dec 2023 14:08:24 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 657EE240049
	for <linux-serial@vger.kernel.org>; Fri,  1 Dec 2023 14:08:24 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 2660F240040;
	Fri,  1 Dec 2023 14:08:24 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 94C0821439;
	Fri,  1 Dec 2023 14:08:23 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Dec 2023 14:08:23 +0100
From: Florian Eckert <fe@dev.tdt.de>
To: Lee Jones <lee@kernel.org>
Cc: Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, pavel@ucw.cz, kabel@kernel.org,
 u.kleine-koenig@pengutronix.de, m.brock@vanmierlo.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-leds@vger.kernel.org
Subject: Re: [Patch v8 0/6] ledtrig-tty: add additional tty state evaluation
In-Reply-To: <170142723852.3350831.6373465907279189004.b4-ty@kernel.org>
References: <20231109085038.371977-1-fe@dev.tdt.de>
 <170142723852.3350831.6373465907279189004.b4-ty@kernel.org>
Message-ID: <8acd2694429af4f7205db7d7bb39eab6@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1701436104-664F8C7C-AEB982EF/0/0



On 2023-12-01 11:40, Lee Jones wrote:
> On Thu, 09 Nov 2023 09:50:32 +0100, Florian Eckert wrote:
>> Changes in v8:
>> ==============
>> - As requested by greg k-h [6], I have send the patch 2/7 of this 
>> series
>>   about the memory leak also to stable.vger.kernel.org [7]. This has
>>   already received a 'Reviewed-by' from Uwe [8].
>> - As requested by Maarten, I have adopted his suggestion to invert the 
>> LED
>>   blink, so that I do not have to save the 'state' in the tty data
>>   struct [9].
>> 
>> [...]
> 
> Applied, thanks!
> 
> [1/6] tty: add new helper function tty_get_tiocm
>       commit: 5d11a4709f552fa139c2439fead05daeb064a6f4
> [2/6] leds: ledtrig-tty: free allocated ttyname buffer on deactivate
>       (no commit info)
> [3/6] leds: ledtrig-tty: change logging if get icount failed
>       (no commit info)
> [4/6] leds: ledtrig-tty: replace mutex with completion
>       (no commit info)
> [5/6] leds: ledtrig-tty: make rx tx activitate configurable
>       (no commit info)
> [6/6] leds: ledtrig-tty: add additional line state evaluation
>       (no commit info)

I think that was a mistake? Patchset v9 is the correct patchset [1]?

Thanks for applying v9 [1]

Best regards

Florian

Links:

[1] 
https://lore.kernel.org/all/170142724145.3350831.5316050550655479371.b4-ty@kernel.org/
