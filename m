From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] serial: vt8500_serial: Fix a parameter of
 find_first_zero_bit.
Date: Tue, 23 Aug 2016 06:20:28 +0200
Message-ID: <57f44339-76c6-051f-b592-2648afaae336@wanadoo.fr>
References: <1471814425-18949-1-git-send-email-christophe.jaillet@wanadoo.fr>
 <2512469.eM8MYFl15l@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <2512469.eM8MYFl15l@wuerfel>
Sender: kernel-janitors-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: gregkh@linuxfoundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux@prisktech.co.nz, linux-serial@vger.kernel.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org

Le 22/08/2016 à 10:42, Arnd Bergmann a écrit :
> [...]
> Sorry, but I'm not following the logic here.
>
> [...]
> You argue that the two have the same meaning, which I see, but
> why is it better than the existing code?
>
> 	Arnd

Hi,

sorry if my explanation was unclear.

What I mean is that if "sizeof(unsigned long) = 4" (i.e. 32 bits systems 
?) then:

	port = find_first_zero_bit(&vt8500_ports_in_use, sizeof(vt8500_ports_in_use));
turns into:
  	port = find_first_zero_bit(&vt8500_ports_in_use, 4);

find_first_zero_bit "Returns the bit number of the first set bit.  If no bits are set, returns @size."
So, in this case, it can return 1, 2, 3 or 4, if one of the 4 first bits is 0.
And will also return 4, if none of the 4 first bits is 0.

In no way, 5 or above can be returned.

The code just after is:
	if (port >= VT8500_MAX_PORTS)
		return -ENODEV;
It turns into:
	if (port >= 6)
		return -ENODEV;


I see 2 problems there:
	- First, according to this test, "port = 5" seems a legal value, but can never trigger.
	- Second, if the first 3 bits are set, the find_first_zero_bit will return 4, whatever the value of the 4th bit.
           This 4 can either mean "4th bit is clear" or "no clear bit found, so return @size (i.e. 4)"

  
Using:
	port = find_first_zero_bit(&vt8500_ports_in_use, BITS_PER_LONG);
Would solve the 2 issues.
    - 4 would really mean, 4th bit is set.
    - 5 becomes a possible value.
    - 6 to 31 would mean: we found a clear bit "in the garbage after the VT8500_MAX_PORTS (i.e. 6) relevant bits".
    - 32 would mean, all bits set.

These answers look more in line with the "if (port >= VT8500_MAX_PORTS)" test.



Finally, what I meant by "Other options are possible:" is:
   - 'vt8500_ports_in_use' being a 'unsigned long', use ffz to reduce code verbosity
	port = ffz(&vt8500_ports_in_use);
     would also work, because it is equivalent to:
	port = find_first_zero_bit(&vt8500_ports_in_use, BITS_PER_LONG);

   - VT8500_MAX_PORTS, in order to be consistent with the test below
	port = find_first_zero_bit(&vt8500_ports_in_use, VT8500_MAX_PORTS);
     would also work and is maybe more logical in regard to the test "if (port >= VT8500_MAX_PORTS)"



Now if "sizeof(unsigned long) = 8" (i.e. 64 bits systems ?), the actual code would work.
But using "sizeof(long)" to mean "more than VT8500_MAX_PORTS" is odd.
In other words, expressing a number of bits using something that gives a size in bytes is, IMHO, spurious.

  
All this is pure speculation.

Hoping that it is clearer now ( and that my analysis is right :) )

Best regard,
CJ


---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

