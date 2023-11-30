Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Greylist: delayed 440 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 06:03:12 PST
Received: from mail.someserver.de (mail.someserver.de [116.202.193.223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE4CB9
	for <linux-serial@vger.kernel.org>; Thu, 30 Nov 2023 06:03:12 -0800 (PST)
Received: from [IPV6:2a02:8109:a893:3b00:7bad:dd01:344c:715f] (unknown [IPv6:2a02:8109:a893:3b00:7bad:dd01:344c:715f])
	by mail.someserver.de (Postfix) with ESMTPSA id 1634AA0BF2;
	Thu, 30 Nov 2023 14:55:48 +0100 (CET)
Message-ID: <37a7a59b-70a8-41fb-b919-9fff8c44f349@christina-quast.de>
Date: Thu, 30 Nov 2023 14:55:47 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND] hid-ft260: Add serial driver
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>,
 Christina Quast <contact@christina-quast.de>
Cc: linux-serial@vger.kernel.org, Daniel Beer
 <daniel.beer@igorinstitute.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20231122094004.95399-1-contact@christina-quast.de>
 <2023112205-explore-frequency-40a6@gregkh>
 <0fb134f7-f72e-4742-9c2d-c68f83b67975@christina-quast.de>
 <2023112831-pacifist-lure-428a@gregkh>
From: Christina Quast <chrysh@christina-quast.de>
In-Reply-To: <2023112831-pacifist-lure-428a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg!

I searched around and many devices seem to configure their own device 
names (ttyPZ, ttyGF, ttySDIO, ttyMX, ttyMI, ttyIPWp, ...), so I think 
ttyFT for all the FTDI devices fits well as a name. I explained it 
better in the commit message in the next patchset I will be sending.

On 11/28/23 11:29, Greg KH wrote:
> On Sun, Nov 26, 2023 at 10:53:18AM +0100, Christina Quast wrote:
>> Hi Greg!
>>
>> Thanks for the comments!
>>
>> On 11/22/23 11:15, Greg KH wrote:
>>> On Wed, Nov 22, 2023 at 10:40:03AM +0100, Christina Quast wrote:
>>>> This commit adds a serial interface /dev/FTx which implements the tty
>>>> serial driver ops, so that it is possible to set the baudrate, send
>>>> and receive data, etc.
>>> Why is this a serial device?  What type of device is it?
>>>
>>> And why "FTx"?  Where did that name come from?  That's not a "normal"
>>> tty name.
>> I meant /dev/ttyFTx. Since it's a hid device providing a serial interface,
>> in theory you could also call it /dev/ttySx or /dev/ttyUSBx, but both feel
>> wrong. It's an FTDI device, that functions as a USB to UART / I2C Master. Do
>> you have a better name in mind?
> I thought we had a HID tty device name already, perhaps dig around for
> that and tie into that interface?  If not, sure, youcan use ttyFTx, but
> it needs to be documented somewhere (and the correct wording here in the
> changelog as well.)
>
> thanks,
>
> greg k-h
