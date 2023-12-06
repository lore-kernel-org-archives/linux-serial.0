Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3A2C6
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 05:57:23 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=1718b185fc=fe@dev.tdt.de>)
	id 1rAsOw-00BDnO-0D
	for linux-serial@vger.kernel.org; Wed, 06 Dec 2023 14:57:22 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1rAsOv-008UKz-Kc
	for linux-serial@vger.kernel.org; Wed, 06 Dec 2023 14:57:21 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 574A8240049
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 14:57:21 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 0FAD2240040;
	Wed,  6 Dec 2023 14:57:21 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 832A534045;
	Wed,  6 Dec 2023 14:57:20 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 06 Dec 2023 14:57:20 +0100
From: Florian Eckert <fe@dev.tdt.de>
To: Lee Jones <lee@kernel.org>
Cc: Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, pavel@ucw.cz, kabel@kernel.org,
 u.kleine-koenig@pengutronix.de, m.brock@vanmierlo.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-leds@vger.kernel.org
Subject: Re: [Patch v8 0/6] ledtrig-tty: add additional tty state evaluation
In-Reply-To: <20231206134719.GF3375667@google.com>
References: <20231109085038.371977-1-fe@dev.tdt.de>
 <170142723852.3350831.6373465907279189004.b4-ty@kernel.org>
 <8acd2694429af4f7205db7d7bb39eab6@dev.tdt.de>
 <20231206134719.GF3375667@google.com>
Message-ID: <e69d088b1aedfef330eace35699670c6@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-ID: 151534::1701871041-6D0F3018-9CFB4300/0/0
X-purgate-type: clean



On 2023-12-06 14:47, Lee Jones wrote:
> On Fri, 01 Dec 2023, Florian Eckert wrote:
>> On 2023-12-01 11:40, Lee Jones wrote:

>> > Applied, thanks!
>> >
>> > [1/6] tty: add new helper function tty_get_tiocm
>> >       commit: 5d11a4709f552fa139c2439fead05daeb064a6f4
>> > [2/6] leds: ledtrig-tty: free allocated ttyname buffer on deactivate
>> >       (no commit info)
>> > [3/6] leds: ledtrig-tty: change logging if get icount failed
>> >       (no commit info)
>> > [4/6] leds: ledtrig-tty: replace mutex with completion
>> >       (no commit info)
>> > [5/6] leds: ledtrig-tty: make rx tx activitate configurable
>> >       (no commit info)
>> > [6/6] leds: ledtrig-tty: add additional line state evaluation
>> >       (no commit info)
>> 
>> I think that was a mistake? Patchset v9 is the correct patchset [1]?
>> 
>> Thanks for applying v9 [1]
> 
> It's automated.  Not sure what happened now.
> 
> Please check to ensure the correct set was applied.

I have checked that v9 is appled to the branch for-leds-next [1].
I can confirm that v9 patchset is applied there.

Thanks

Best regards

Florian

Links:
[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git/log/?h=for-leds-next
