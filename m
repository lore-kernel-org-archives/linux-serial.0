From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Insanely high baud rates
Date: Tue, 9 Oct 2018 13:02:44 -0700
Message-ID: <3422d3a3-b577-99eb-2e05-69d8d5283695@zytor.com>
References: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com>
 <20181009195139.GB30972@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009195139.GB30972@1wt.eu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Willy Tarreau <w@1wt.eu>
Cc: linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-serial@vger.kernel.org

On 10/09/18 12:51, Willy Tarreau wrote:
> On Tue, Oct 09, 2018 at 12:19:04PM -0700, H. Peter Anvin wrote:
>> [Resending to a wider audience]
>>
>> In trying to get the termios2 interface actually implemented in glibc,
>> the question came up if we will ever care about baud rates in excess of
>> 4 Gbps, even in the relatively remote future.
>>
>> If this is something we care about *at all*, I would like to suggest
>> that rather than defining yet another kernel interface, we steal some
>> bits from the MSB of the speed fields, alternatively one of the c_cc
>> bytes (all  likearchitectures seem to have c_cc[18] free) or some field,
>> if we can find them, in c_cflags, to indicate an exponent.
>>
>> With 5 bits from the top of the speed fields, the current values would
>> be identical up to 248 Gbps, and values up to ~288 Pbps would be
>> encodable ±2 ppb.
>>
>> In the short term, all we would have to do in the kernel would be
>> erroring out on baud rates higher than 0x0fffffff (2^28-1 due to
>> implicit one aliasing rhe first bit of a 5-bit exponent - less than 2^27
>> are functionally denorms.) However, I'd like to put the glibc
>> infrastructure for this now if this is something we may ever be
>> interested in.
>>
>> Thoughts?
> 
> Just my two cents, maybe we can conclude that for now we don't care
> thus don't implement anything, but that everything you identified as
> a possible place to steal bits should be marked "reserved for future
> use, must be sent as zero". This will leave you ample room later to
> decide how to proceed (and maybe it will not be the bps that you'll
> want to change but the number of lanes, or word size, or bit encoding,
> especially at 4 Gbps).
> 

Well, it would be nice to be able to pre-enable it in glibc as much as
possible.  What I'm thinking of doing is to use a 64-bit "baud_t" type
in glibc, and reserve the upper 4 bits of the speed field as must be
zero (which is de facto the case anyway.) In other to avoid a *huge*
user space ABI versioning mess we need to be able to encode the baud
rate inside a 32-bit speed_t in glibc, and given that I believe it would
be a Very Nice Thing if we could squeeze the information into 32 bits on
the kernel side as well.

So reserving the upper 4 bits I think is The Right Thing. I think that
is actually a null change.

I'm not sure if it would be a good idea to make the kernel -EINVAL on
currently-unused c_cc bytes or c_*flags; I can see pros and cons (the
latter being in no small part that that is not legacy behavior.)

	-hpa
