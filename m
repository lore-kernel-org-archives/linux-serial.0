From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: Re: [PATCH 3/3] serial: make PCI device id constant
Date: Sun, 10 Jan 2010 20:43:51 +0100
Message-ID: <4B4A2DF7.5020907@freemail.hu>
References: <4B4A077C.7020406@freemail.hu>
	<e2d7436a1001100951w4dd7139as96e5808872f5c926@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <cocci-bounces@diku.dk>
In-Reply-To: <e2d7436a1001100951w4dd7139as96e5808872f5c926@mail.gmail.com>
List-Unsubscribe: <http://lists.diku.dk/mailman/listinfo/cocci>,
	<mailto:cocci-request@diku.dk?subject=unsubscribe>
List-Archive: <http://lists.diku.dk/pipermail/cocci>
List-Post: <mailto:cocci@diku.dk>
List-Help: <mailto:cocci-request@diku.dk?subject=help>
List-Subscribe: <http://lists.diku.dk/mailman/listinfo/cocci>,
	<mailto:cocci-request@diku.dk?subject=subscribe>
Sender: cocci-bounces@diku.dk
Errors-To: cocci-bounces@diku.dk
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: cocci@diku.dk, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Micha=B3 Miros=B3aw wrote:
> 2010/1/10 N=E9meth M=E1rton <nm127@freemail.hu>:
>> From: M=E1rton N=E9meth <nm127@freemail.hu>
>>
>> The id_table field of the struct pci_driver is constant in <linux/pci.=
h>
>> so it is worth to make initialization data also constant.
> [...]
>> diff -u -p a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
>> --- a/drivers/serial/8250_pci.c 2009-12-03 04:51:21.000000000 +0100
>> +++ b/drivers/serial/8250_pci.c 2010-01-08 18:40:05.000000000 +0100
>> @@ -2567,7 +2567,7 @@ static int pciserial_resume_one(struct p
>>  }
>>  #endif
>>
>> -static struct pci_device_id serial_pci_tbl[] =3D {
>> +static const struct pci_device_id serial_pci_tbl[] =3D {
>>        /* Advantech use PCI_DEVICE_ID_ADVANTECH_PCI3620 (0x3620) as 'P=
CI_SUBVENDOR_ID' */
>>        {       PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI362=
0,
>>                PCI_DEVICE_ID_ADVANTECH_PCI3620, 0x0001, 0, 0,
> [...]
>=20
> There was similar patch sent to netdev couple days ago. For PCI
> devices it used DEFINE_PCI_DEVICE_TABLE() like this:
>=20
> static DEFINE_PCI_DEVICE_TABLE(serial_pci_tbl) =3D {
>=20
> so that the ID data went to the proper .ko section.

Thanks for the feedback. The DEFINE_PCI_DEVICE_TABLE() is also recommende=
d
by Documentation/PCI/pci.txt .

Regads,

	M=E1rton N=E9meth
_______________________________________________
Cocci mailing list
Cocci@diku.dk
http://lists.diku.dk/mailman/listinfo/cocci
(Web access from inside DIKUs LAN only)
