Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.someserver.de (mail.someserver.de [116.202.193.223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E5810F0
	for <linux-serial@vger.kernel.org>; Thu, 30 Nov 2023 05:38:13 -0800 (PST)
Received: from [IPV6:2a02:8109:a893:3b00:7bad:dd01:344c:715f] (unknown [IPv6:2a02:8109:a893:3b00:7bad:dd01:344c:715f])
	by mail.someserver.de (Postfix) with ESMTPSA id C63CEA21A8;
	Thu, 30 Nov 2023 14:38:10 +0100 (CET)
Message-ID: <98e6159b-e429-48ae-baa3-1dd87e9e8482@christina-quast.de>
Date: Thu, 30 Nov 2023 14:38:10 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND] hid-ft260: Add serial driver
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 linux-serial <linux-serial@vger.kernel.org>,
 Daniel Beer <daniel.beer@igorinstitute.com>
References: <20231122094004.95399-1-contact@christina-quast.de>
 <2023112205-explore-frequency-40a6@gregkh>
 <0fb134f7-f72e-4742-9c2d-c68f83b67975@christina-quast.de>
 <aa99b5f-6f6e-47c7-5956-5034c681d0d7@linux.intel.com>
From: Christina Quast <contact@christina-quast.de>
In-Reply-To: <aa99b5f-6f6e-47c7-5956-5034c681d0d7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ilpo!

On 11/28/23 11:13, Ilpo Järvinen wrote:
> On Sun, 26 Nov 2023, Christina Quast wrote:
>
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
>> I meant /dev/ttyFTx. Since it's a hid device providing a serial interface, in
>> theory you could also call it /dev/ttySx or /dev/ttyUSBx, but both feel wrong.
>> It's an FTDI device, that functions as a USB to UART / I2C Master. Do you have
>> a better name in mind?
>>>> +struct ft260_uart_write_request_report {
>>>> +	u8 report;		/* FT260_UART_REPORT */
>>>> +	u8 length;		/* data payload length */
>>>> +	u8 data[];		/* data payload */
>>> Shouldn't this be marked as counted by length?
>> Do you mean in the comment?
> No, try:
>
> git grep __counted_by
>
>>>> +		req.data_bit = FT260_CFG_DATA_BITS_8;
>>>> +		termios->c_cflag &= ~CSIZE;
>>>> +		termios->c_cflag |= CS8;
>>>> +		break;
>>>> +	default:
>>>> +	case CS8:
>>>> +		req.data_bit = FT260_CFG_DATA_BITS_8;
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	req.stop_bit = (termios->c_cflag & CSTOPB) ?
>>>> +		FT260_CFG_STOP_TWO_BIT : FT260_CFG_STOP_ONE_BIT;
>>>> +
>>>> +	if (termios->c_cflag & PARENB) {
>>>> +		req.parity = (termios->c_cflag & PARODD) ?
>>>> +			FT260_CFG_PAR_ODD : FT260_CFG_PAR_EVEN;
>>>> +	} else {
>>>> +		req.parity = FT260_CFG_PAR_NO;
>>>> +	}
>>>> +
>>>> +	baud = tty_termios_baud_rate(termios);
>>>> +	if (baud == 0 || baud < FT260_CFG_BAUD_MIN || baud >
>>>> FT260_CFG_BAUD_MAX) {
>>>> +		struct tty_struct *tty = tty_port_tty_get(&port->port);
>>> Blank line needed here.
>>>
>>>> +		hid_err(hdev, "Invalid baud rate %d\n", baud);
>>> Again, debug error?  And why not report an error instead of just setting
>>> it to 9600?
>>>
>>> And why 9600?
>> This is a default setting used in the FT260 documentation as default value, so
>> it seemed like a sensible value.
>>
>> The ft260_uart_change_speed function is called in set_termios, which has a
>> void return type. So even if I returned an error, that would not be propagated
>> to userspace. It looks like the userspace is meant to check what values were
>> actually set with a subsequent ioctl call.
> Setting termios does not propagate errors (legacy feature, I don't know
> the reason).
>
> However, every set termios handling function should ensure if any value
> from the input termios is changed because the HW cannot do what has been
> requested, the changes should be reflected in the termios so that
> userspace knows about them (could check but I don't know if any userspace
> application actually does that, and I'm quite skeptical they would).
>
> IIRC, termios is returned also from the setting call.
>
This is also what I understood, for example form this site: 
https://man.archlinux.org/man/ioctl_tty.2.de. In the C code example, the 
configure the new serial port settings, and then get the new values 
again to see what was really configured.

--

chrysh

