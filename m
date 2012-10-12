From: "Reddy Kaveri, Praveen Kumar" <praveen-kumar.reddy-kaveri@hp.com>
Subject: RE: PL2303 Driver Issue
Date: Fri, 12 Oct 2012 22:15:08 +0000
Message-ID: <523E9909A6DFCF469669581BEB8DA7AA5692A2B7@G2W2441.americas.hpqcorp.net>
References: <523E9909A6DFCF469669581BEB8DA7AA56928B25@G2W2441.americas.hpqcorp.net>
 <20121007144700.GA18178@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_523E9909A6DFCF469669581BEB8DA7AA5692A2B7G2W2441americas_"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:42515 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab2JLWQU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Oct 2012 18:16:20 -0400
In-Reply-To: <20121007144700.GA18178@kroah.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

--_002_523E9909A6DFCF469669581BEB8DA7AA5692A2B7G2W2441americas_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thanks for your assistance.

I am using RXTXComm API for getting list of serial ports and available USB =
ports. I have attached the java code for your kind glance.
For some of the point of sales machines the telxon device is working.=20

If the connection is successful, the following information is displaying.

Bus 001 Device 003: ID 0557:2008 ATEN International Co. Ltd.
                Language IDs: none (invalid length string descriptor 63; le=
n=3D7)

If the connection is failed, the following information is displaying.

Bus 001 Device 002: ID 0557:2008 ATEN International Co. Ltd.
string descriptor 1 invalid (00 00; len=3D52)
string descriptor 2 invalid (00 00; len=3D48)

I am less proficient in linux. So kindly help me in resolving this issue.

What does it mean "string descriptor 1 invalid"?
Is it causing the problem. If so please let know how to resolve this.


Thanks & Regards,
Praveen Kumar Reddy K
Hewlett-Packard Company

#101, 1035 64 Ave SE ,Calgary, AB,=A0T2H 2J7, CANADA

+1 403 692 7914 / Tel=20
+1 403=A0619=A08242 / Mobile=20
praveen-kumar.reddy-kaveri@hp.com=A0/ Email




-----Original Message-----
From: Greg KH [mailto:greg@kroah.com]=20
Sent: Sunday, October 07, 2012 8:47 AM
To: Reddy Kaveri, Praveen Kumar
Cc: linux-serial@vger.kernel.org
Subject: Re: PL2303 Driver Issue

On Sat, Oct 06, 2012 at 06:33:19PM +0000, Reddy Kaveri, Praveen Kumar wrote=
:
> Hi,
>=20
> I am using Telxon PTC-710 device in linux environment and I am using
> RS232 Serial to USB converter. When I connect the device to USB port
> it is detecting and showing in the system log as "attached to
> ttyUSB0".=A0 I have written a java program to display all the available
> ports. But this program is displaying only ttyS0 &ttyS1. I have tried
> to set all permissions to the user as well as to port. Please help me
> if I am missing any configuration related to this driver.

You are going to have to modify your userspace program to know to look
for the ttyUSBX devices as well.  There's nothing the kernel can do
about this.

As you wrote the program, how are you getting the list of serial devices
in the system?

greg k-h

--_002_523E9909A6DFCF469669581BEB8DA7AA5692A2B7G2W2441americas_
Content-Type: application/octet-stream; name="SerialProgramming.java"
Content-Description: SerialProgramming.java
Content-Disposition: attachment; filename="SerialProgramming.java"; size=1838;
	creation-date="Sat, 29 Sep 2012 20:25:12 GMT";
	modification-date="Sun, 30 Sep 2012 07:21:52 GMT"
Content-Transfer-Encoding: base64

cGFja2FnZSBjb20ubWFya3MuYnVpbGRlcjsNCg0KaW1wb3J0IGdudS5pby5Db21tUG9ydElkZW50
aWZpZXI7DQppbXBvcnQgZ251LmlvLlBvcnRJblVzZUV4Y2VwdGlvbjsNCmltcG9ydCBnbnUuaW8u
U2VyaWFsUG9ydDsNCmltcG9ydCBnbnUuaW8uVW5zdXBwb3J0ZWRDb21tT3BlcmF0aW9uRXhjZXB0
aW9uOw0KDQppbXBvcnQgamF2YS5pby5JT0V4Y2VwdGlvbjsNCmltcG9ydCBqYXZhLmlvLk91dHB1
dFN0cmVhbTsNCmltcG9ydCBqYXZhLnV0aWwuRW51bWVyYXRpb247DQoNCnB1YmxpYyBjbGFzcyBT
ZXJpYWxQcm9ncmFtbWluZyB7DQogICAgc3RhdGljIEVudW1lcmF0aW9uIHBvcnRMaXN0Ow0KICAg
IHN0YXRpYyBDb21tUG9ydElkZW50aWZpZXIgcG9ydElkOw0KICAgIHN0YXRpYyBTdHJpbmcgbWVz
c2FnZVN0cmluZyA9ICJIZWxsbywgd29ybGQhXG4iOw0KICAgIHN0YXRpYyBTZXJpYWxQb3J0IHNl
cmlhbFBvcnQ7DQogICAgc3RhdGljIE91dHB1dFN0cmVhbSBvdXRwdXRTdHJlYW07DQoNCiAgICBw
dWJsaWMgc3RhdGljIHZvaWQgbWFpbihTdHJpbmdbXSBhcmdzKSB7DQogICAgICAgIHBvcnRMaXN0
ID0gQ29tbVBvcnRJZGVudGlmaWVyLmdldFBvcnRJZGVudGlmaWVycygpOw0KDQogICAgICAgIHdo
aWxlIChwb3J0TGlzdC5oYXNNb3JlRWxlbWVudHMoKSkgew0KICAgICAgICAgICAgcG9ydElkID0g
KENvbW1Qb3J0SWRlbnRpZmllcikgcG9ydExpc3QubmV4dEVsZW1lbnQoKTsNCiAgICAgICAgICAg
IFN5c3RlbS5vdXQucHJpbnRsbihwb3J0SWQuZ2V0TmFtZSgpKTsNCiAgICAgICAgICAgIGlmIChw
b3J0SWQuZ2V0UG9ydFR5cGUoKSA9PSBDb21tUG9ydElkZW50aWZpZXIuUE9SVF9TRVJJQUwpIHsN
CiAgICAgICAgICAgICAgICAgaWYgKHBvcnRJZC5nZXROYW1lKCkuZXF1YWxzKCJDT00zIikpIHsN
CiAgICAgICAgICAgICAgICAvL2lmIChwb3J0SWQuZ2V0TmFtZSgpLmVxdWFscygiL2Rldi90ZXJt
L2EiKSkgew0KICAgICAgICAgICAgICAgICAgICB0cnkgew0KICAgICAgICAgICAgICAgICAgICAg
ICAgc2VyaWFsUG9ydCA9IChTZXJpYWxQb3J0KQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHBvcnRJZC5vcGVuKCJTaW1wbGVXcml0ZUFwcCIsIDIwMDApOw0KICAgICAgICAgICAgICAgICAg
ICB9IGNhdGNoIChQb3J0SW5Vc2VFeGNlcHRpb24gZSkge30NCiAgICAgICAgICAgICAgICAgICAg
dHJ5IHsNCiAgICAgICAgICAgICAgICAgICAgICAgIG91dHB1dFN0cmVhbSA9IHNlcmlhbFBvcnQu
Z2V0T3V0cHV0U3RyZWFtKCk7DQogICAgICAgICAgICAgICAgICAgIH0gY2F0Y2ggKElPRXhjZXB0
aW9uIGUpIHt9DQogICAgICAgICAgICAgICAgICAgIHRyeSB7DQogICAgICAgICAgICAgICAgICAg
ICAgICBzZXJpYWxQb3J0LnNldFNlcmlhbFBvcnRQYXJhbXMoOTYwMCwNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBTZXJpYWxQb3J0LkRBVEFCSVRTXzgsDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgU2VyaWFsUG9ydC5TVE9QQklUU18xLA0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFNlcmlhbFBvcnQuUEFSSVRZX05PTkUpOw0KICAgICAgICAgICAgICAgICAgICB9IGNhdGNo
IChVbnN1cHBvcnRlZENvbW1PcGVyYXRpb25FeGNlcHRpb24gZSkge30NCiAgICAgICAgICAgICAg
ICAgICAgdHJ5IHsNCiAgICAgICAgICAgICAgICAgICAgICAgIG91dHB1dFN0cmVhbS53cml0ZSht
ZXNzYWdlU3RyaW5nLmdldEJ5dGVzKCkpOw0KICAgICAgICAgICAgICAgICAgICB9IGNhdGNoIChJ
T0V4Y2VwdGlvbiBlKSB7fQ0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgIH0NCiAgICAg
ICAgfQ0KICAgIH0NCn0=

--_002_523E9909A6DFCF469669581BEB8DA7AA5692A2B7G2W2441americas_--
