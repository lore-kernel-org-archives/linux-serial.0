From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v3 -next 11/11] serial: 8250_early: Remove setup_early_serial8250_console()
Date: Fri, 03 Apr 2015 21:16:04 -0400
Message-ID: <551F3B54.3070707@hurleysoftware.com>
References: <1425932842-21812-1-git-send-email-peter@hurleysoftware.com>	<551CB5DF.1010108@hurleysoftware.com>	<CAE9FiQVKY9KLeBOB0shqTPZZipsmAiU=3_8gzfFhsCW9kxo_uA@mail.gmail.com>	<551D6EEA.6050704@hurleysoftware.com>	<CAE9FiQUGeGuf9z0tQyjOujfRW_RtrWe8ELeKe=W6GNFmRVdpfg@mail.gmail.com>	<CAE9FiQVBxGt_jX-juzf4vvc_6MgiiSixW6RtVTz1aUTw0h3Rmg@mail.gmail.com>	<CAE9FiQVaM650O139RgLcHRv7NGUVVMqSETq0YJ+7OAWVg=0Y0A@mail.gmail.com>	<CAE9FiQUJq0zi2gx0jM1AQp60FhyaytKEMV_mpY+fNc3OATnCBA@mail.gmail.com>	<CAE9FiQV0rfOfo3-=yQOYLDD-x+48_OuWfkHVNy-+oTzWvgr9Ew@mail.gmail.com>	<CAE9FiQX2gQQcD5OrFkDCN5Ew746H1kd5+VgpAcSNvEqg-gFx7Q@mail.gmail.com>	<551E6D61.7000501@hurleysoftware.com>	<CAE9FiQXaOZOf4hj72iUpDoYgGTuO+jwF34qOeiLw=3rrWK+ucA@mail.gmail.com>	<551ED011.1030004@hurleysoftware.com>	<CAE9FiQW4PM1aozMOXMfve
 y2=zVjm3uMVLGW3924eidACBbTjag@mail.gmail.com>	<551EDB92.9070008@hurleysoftware.com> <CAE9FiQV1BF9R5Roc1HDRX+03h+Enb13seRNhYxE5P6CgUb02yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE9FiQV1BF9R5Roc1HDRX+03h+Enb13seRNhYxE5P6CgUb02yA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 04/03/2015 08:52 PM, Yinghai Lu wrote:
> On Fri, Apr 3, 2015 at 11:27 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 04/03/2015 01:44 PM, Yinghai Lu wrote:
>>> On Fri, Apr 3, 2015 at 10:38 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>> On 04/03/2015 12:57 PM, Yinghai Lu wrote:
>>>>
>>>> Wait -- you have earlycon in a product??
>>>
>>> What do you mean?
>>
>> I mean, what will happen if I put in a big debug banner like Steven
>> did for ftrace?
>>
>> Kernel developers need earlycon for debugging arch code; often the earlycon
>> is just hacked together especially when it requires fixmap support.
>>
>> Putting it in a product and _relying on undocumented behavior_ is a bad idea.
> 
> let me repeat again:
> when you have "console=uart8250,io,0x3f8", you will have earlycon and
> then console.
> 
> That is just for kernel developer for debugging.
> 
> When you have x86 with bunch of dimms and cpus, user will have to wait couple
> of minutes to output from console=ttyS0....and if it hang early, no
> one would know what happen.
> 
> Also it is only boot time only....

The fix is sitting in your inbox. Pointless to discuss it now.
