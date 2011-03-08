From: =?ISO-8859-14?Q?Eric_B=E9nard?= <eric@eukrea.com>
Subject: Re: [PATCH 1/2] n_gsm: improve behaviour with encoding 0
Date: Tue, 08 Mar 2011 17:16:24 +0100
Message-ID: <4D765658.7070301@eukrea.com>
References: <1299543872-14580-1-git-send-email-eric@eukrea.com> <20110308130145.3bacbe1b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040500060503030109070902"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:39614 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab1CHQZ1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 Mar 2011 11:25:27 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 33101D1AD08
	for <linux-serial@vger.kernel.org>; Tue,  8 Mar 2011 17:17:06 +0100 (CET)
In-Reply-To: <20110308130145.3bacbe1b@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------040500060503030109070902
Content-Type: text/plain; charset=ISO-8859-14; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alan,

On 08/03/2011 14:01, Alan Cox wrote:
> On Tue,  8 Mar 2011 01:24:31 +0100
> Eric Bénard<eric@eukrea.com>  wrote:
>
>> * on Telit&  Sim.com modems, using encoding 0, opening a new DLC
>> randomly fails. Not setting PF bit of the control byte gives a
>> reliable behaviour on these modems.
>
> Any change needs doing with reference to the standard not modem specific
> hacks. Chances are the modem is right about the PF bit and we perhaps are
> not - but it's not an encoding dependant bit so the patch is certainly
> wrong.
>
> In this case:
>
> 5.4.3.1 says (of UI/UIH etc) 'both stations shall set the P bit to 0'
>
> so the modem is right and we are wrong.
>
> I think what is actually needed is to just remove the PF setting
> completely for that function. Obviously the other modems don't care or
> check the bit.
>
Thanks for the right analysis, I got lost in the specification and didn't 
found this. I'll update the patch as per your comments and resend a v2.

While testing this, I met several problems with Telit modems. I didn't found 
anything suspicious in the log.

I attach the log for the 2 following case :
- Simcom SIM300 : mux establish fine, pppd launch and the link establish (I 
interrupted the process), a serial terminal can talk to the modem and get answer,
- Telit UC864E : mux establish fine, pppd blocks after sending AT, a serial 
terminal can talk to the modem and get answer so I don't understand why chat 
fails,

In the 2 cases, I'm using the same kernel, on the same model of ARM9 System On 
Module, on the same UART (and I switched the SOM between Telit/Simcom boards 
to be sure the problem doesn't come from here).
And in the 2 cases, pppd works fine on the physical serial link.

If you have any idea of where to search for the problem I can do some tests.

Thanks,
Eric

--------------040500060503030109070902
Content-Type: text/plain;
 name="log_simcom_300.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="log_simcom_300.txt"

[  105.290000] F9 03 3F 01 1C F9 
[  105.290000] --> 0) C: SABM(P)
[  105.310000] F9 03 73 01 D7 F9 
[  105.310000] <-- 0) C: UA(P)

launch ppp :
[  150.820000] F9 0B 3F 01 59 F9 
[  150.830000] --> 2) C: SABM(P)
[  150.830000] Q>  0) C: UIH(F)
[  150.830000] E3 05 0B 0D 
[  150.830000] F9 03 EF 09 E3 05 0B 0D FB F9 
[  150.830000] F9 03 EF 09 E3 05 0B 0D FB F9 
[  150.850000] F9 0B 73 01 92 F9 F9 01 EF 0B E3 07 0B 0D 01 79 
[  150.850000] F9 
[  150.850000] <-- 2) C: UA(P)
[  150.860000] <-- 0) R: UIH(F)
[  150.860000] E3 07 0B 0D 01 
[  150.860000] Q>  0) C: UIH(F)
[  150.860000] E1 07 0B 0D 01 
[  150.860000] F9 03 EF 0B E1 07 0B 0D 01 18 F9 
[  150.860000] F9 03 EF 0B E1 07 0B 0D 01 18 F9 
[  150.890000] F9 03 EF 09 E1 05 0B 0D FB F9 
[  150.890000] <-- 0) C: UIH(F)
[  150.890000] E1 05 0B 0D 
[  150.900000] Q>  0) C: UIH(F)
[  150.900000] E3 05 0B 05 
[  150.900000] F9 03 EF 09 E3 05 0B 05 FB F9 
[  150.900000] F9 03 EF 09 E3 05 0B 05 FB F9 
[  150.920000] F9 03 EF 
[  150.920000] 09 E1 05 0B 05 FB F9 
[  150.920000] <-- 0) C: UIH(F)
[  150.920000] E1 05 0B 05 
[  151.970000] Q>  2) C: UIH(F)
[  151.970000] 41 		=> A
[  151.970000] F9 0B EF 03 41 53 F9 
[  151.970000] F9 0B EF 03 41 53 F9 
[  151.990000] Q>  2) C: UIH(F)
[  151.990000] 54 		=> T
[  151.990000] F9 0B EF 03 54 53 F9 
[  151.990000] F9 0B EF 03 54 53 F9 
[  152.000000] F9 09 EF 03 41 32 F9 
[  152.000000] <-- 2) R: UIH(F)
[  152.010000] 41 		<= A
[  152.010000] F9 09 EF 03 54 32 F9 
[  152.010000] <-- 2) R: UIH(F)
[  152.020000] Q>  2) C: UIH(F)
[  152.020000] 5A 		=> Z
[  152.020000] F9 0B EF 03 5A 53 F9 
[  152.020000] F9 0B EF 03 5A 53 F9 
[  152.030000] 54 		<= T
[  152.040000] Q>  2) C: UIH(F)
[  152.040000] 0D 		=> \r
[  152.040000] F9 0B EF 03 0D 53 F9 
[  152.040000] F9 0B EF 03 0D 53 F9 
[  152.060000] F9 09 EF 03 5A 32 F9 
[  152.060000] <-- 2) R: UIH(F)
[  152.060000] 5A 		<= Z
[  152.060000] F9 09 EF 03 0D 32 F9 
[  152.070000] <-- 2) R: UIH(F)
[  152.070000] 0D 		<= \r
[  152.110000] F9 09 EF 0D 0D 0A 4F 4B 0D 0A D8 F9 	<= OK\r\n
[  152.110000] <-- 2) R: UIH(F)
[  152.110000] 0D 0A 4F 4B 0D 0A 
[  152.140000] Q>  2) C: UIH(F)
[  152.140000] 41 
[  152.140000] F9 0B EF 03 41 53 F9 
[  152.140000] F9 0B EF 03 41 53 F9 
[  152.160000] Q>  2) C: UIH(F)
[  152.160000] 54 
[  152.160000] F9 0B EF 03 54 53 F9 
[  152.160000] F9 0B EF 03 54 53 F9 
[  152.180000] F9 09 EF 03 41 32 F9 
[  152.180000] <-- 2) R: UIH(F)
[  152.180000] 41 
[  152.180000] F9 09 
[  152.190000] Q>  2) C: UIH(F)
[  152.190000] 2B 
[  152.190000] F9 0B EF 03 2B 53 F9 
[  152.190000] F9 0B EF 03 2B 53 F9 
[  152.200000] EF 03 54 32 F9 
[  152.200000] <-- 2) R: UIH(F)
[  152.210000] 54 
[  152.220000] Q>  2) C: UIH(F)
[  152.220000] 43 
[  152.220000] F9 0B EF 03 43 53 F9 
[  152.220000] F9 0B EF 03 43 53 F9 
[  152.240000] F9 09 EF 03 2B 32 F9 
[  152.240000] <-- 2) R: UIH(F)
[  152.240000] 2B 
[  152.240000] F9 09 
[  152.250000] Q>  2) C: UIH(F)
[  152.250000] 47 
[  152.250000] F9 0B EF 03 47 53 F9 
[  152.250000] F9 0B EF 03 47 53 F9 
[  152.260000] EF 03 43 32 F9 
[  152.260000] <-- 2) R: UIH(F)
[  152.270000] 43 
[  152.270000] Q>  2) C: UIH(F)
[  152.270000] 44 
[  152.270000] F9 0B EF 03 44 53 F9 
[  152.270000] F9 0B EF 03 44 53 F9 
[  152.290000] F9 09 EF 03 47 32 F9 
[  152.290000] <-- 2) R: UIH(F)
[  152.290000] 47 
[  152.290000] F9 09 
[  152.300000] Q>  2) C: UIH(F)
[  152.300000] 43 
[  152.300000] F9 0B EF 03 43 53 F9 
[  152.300000] F9 0B EF 03 43 53 F9 
[  152.310000] EF 03 44 32 F9 
[  152.310000] <-- 2) R: UIH(F)
[  152.320000] 44 
[  152.320000] Q>  2) C: UIH(F)
[  152.320000] 4F 
[  152.320000] F9 0B EF 03 4F 53 F9 
[  152.320000] F9 0B EF 03 4F 53 F9 
[  152.340000] F9 09 EF 03 43 32 F9 
[  152.340000] <-- 2) R: UIH(F)
[  152.340000] 43 
[  152.340000] Q>  2) C: UIH(F)
[  152.340000] 4E 
[  152.340000] F9 0B EF 03 4E 53 F9 
[  152.340000] F9 0B EF 03 4E 53 F9 
[  152.370000] F9 09 EF 03 4F 32 F9 
[  152.370000] <-- 2) R: UIH(F)
[  152.370000] 4F 
[  152.370000] F9 09 
[  152.380000] Q>  2) C: UIH(F)
[  152.380000] 54 
[  152.380000] F9 0B EF 03 54 53 F9 
[  152.380000] F9 0B EF 03 54 53 F9 
[  152.390000] EF 03 4E 32 F9 
[  152.390000] <-- 2) R: UIH(F)
[  152.400000] 4E 
[  152.410000] Q>  2) C: UIH(F)
[  152.410000] 3D 
[  152.410000] F9 0B EF 03 3D 53 F9 
[  152.410000] F9 0B EF 03 3D 53 F9 
[  152.420000] F9 09 EF 03 54 32 F9 
[  152.420000] <-- 2) R: UIH(F)
[  152.430000] 54 
[  152.430000] F9 09 EF 03 3D 
[  152.430000] 32 F9 
[  152.430000] <-- 2) R: 
[  152.440000] Q>  2) C: UIH(F)
[  152.440000] 31 
[  152.440000] F9 0B EF 03 31 53 F9 
[  152.440000] F9 0B EF 03 31 53 F9 
[  152.450000] UIH(F)
[  152.450000] 3D 
[  152.460000] Q>  2) C: UIH(F)
[  152.460000] 2C 
[  152.460000] F9 0B EF 03 2C 53 F9 
[  152.460000] F9 0B EF 03 2C 53 F9 
[  152.480000] F9 09 EF 03 31 32 F9 
[  152.480000] <-- 2) R: UIH(F)
[  152.480000] 31 
[  152.500000] F9 09 EF 
[  152.500000] 03 2C 32 F9 
[  152.500000] <-- 2) R: UIH(F)
[  152.500000] 2C 
[  152.500000] Q>  2) C: UIH(F)
[  152.500000] 22 
[  152.500000] F9 0B EF 03 22 53 F9 
[  152.500000] F9 0B EF 03 22 53 F9 
[  152.530000] Q>  2) C: UIH(F)
[  152.530000] 49 
[  152.530000] F9 0B EF 03 49 53 F9 
[  152.530000] F9 0B EF 03 49 53 F9 
[  152.550000] F9 09 EF 03 22 32 F9 
[  152.550000] <-- 2) R: UIH(F)
[  152.550000] 22 
[  152.550000] F9 09 
[  152.560000] Q>  2) C: UIH(F)
[  152.560000] 50 
[  152.560000] F9 0B EF 03 50 53 F9 
[  152.560000] F9 0B EF 03 50 53 F9 
[  152.570000] EF 03 49 32 F9 
[  152.570000] <-- 2) R: UIH(F)
[  152.580000] 49 
[  152.590000] Q>  2) C: UIH(F)
[  152.590000] 22 
[  152.590000] F9 0B EF 03 22 53 F9 
[  152.590000] F9 0B EF 03 22 53 F9 
[  152.610000] F9 09 EF 03 50 32 F9 
[  152.610000] <-- 2) R: UIH(F)
[  152.610000] 50 
[  152.610000] F9 09 
[  152.620000] Q>  2) C: UIH(F)
[  152.620000] 2C 
[  152.620000] F9 0B EF 03 2C 53 F9 
[  152.620000] F9 0B EF 03 2C 53 F9 
[  152.630000] EF 03 22 32 F9 
[  152.630000] <-- 2) R: UIH(F)
[  152.640000] 22 
[  152.640000] Q>  2) C: UIH(F)
[  152.640000] 22 
[  152.640000] F9 0B EF 03 22 53 F9 
[  152.640000] F9 0B EF 03 22 53 F9 
[  152.660000] F9 09 EF 03 2C 32 F9 
[  152.660000] <-- 2) R: UIH(F)
[  152.660000] 2C 
[  152.660000] F9 09 
[  152.670000] Q>  2) C: UIH(F)
[  152.670000] 77 
[  152.670000] F9 0B EF 03 77 53 F9 
[  152.670000] F9 0B EF 03 77 53 F9 
[  152.680000] EF 03 22 32 F9 
[  152.680000] <-- 2) R: UIH(F)
[  152.690000] 22 
[  152.690000] F9 09 
[  152.690000] Q>  2) C: UIH(F)
[  152.690000] 65 
[  152.690000] F9 0B EF 03 65 53 F9 
[  152.690000] F9 0B EF 03 65 53 F9 
[  152.700000] EF 03 77 32 F9 
[  152.710000] <-- 2) R: UIH(F)
[  152.710000] 77 
[  152.720000] Q>  2) C: UIH(F)
[  152.720000] 62 
[  152.720000] F9 0B EF 03 62 53 F9 
[  152.720000] F9 0B EF 03 62 53 F9 
[  152.740000] F9 09 EF 03 65 32 F9 
[  152.740000] <-- 2) R: UIH(F)
[  152.740000] 65 
[  152.740000] F9 09 
[  152.750000] Q>  2) C: UIH(F)
[  152.750000] 73 
[  152.750000] F9 0B EF 03 73 53 F9 
[  152.750000] F9 0B EF 03 73 53 F9 
[  152.760000] EF 03 62 32 F9 
[  152.760000] <-- 2) R: UIH(F)
[  152.770000] 62 
[  152.770000] Q>  2) C: UIH(F)
[  152.770000] 66 
[  152.770000] F9 0B EF 03 66 53 F9 
[  152.770000] F9 0B EF 03 66 53 F9 
[  152.790000] F9 09 EF 03 73 32 F9 
[  152.790000] <-- 2) R: UIH(F)
[  152.790000] 73 
[  152.790000] Q>  2) C: UIH(F)
[  152.790000] 72 
[  152.790000] F9 0B EF 03 72 53 F9 
[  152.790000] F9 0B EF 03 72 53 F9 
[  152.820000] F9 09 EF 03 66 32 F9 F9 09 EF 03 72 32 F9 
[  152.820000] <-- 2) R: UIH(F)
[  152.820000] 66 
[  152.830000] Q>  2) C: UIH(F)
[  152.830000] 22 
[  152.830000] F9 0B EF 03 22 53 F9 
[  152.830000] F9 0B EF 03 22 53 F9 
[  152.840000] 
[  152.840000] <-- 2) R: UIH(F)
[  152.840000] 72 
[  152.860000] F9 
[  152.860000] Q>  2) C: UIH(F)
[  152.860000] 0D 
[  152.860000] F9 0B EF 03 0D 53 F9 
[  152.860000] F9 0B EF 03 0D 53 F9 
[  152.870000] 09 EF 03 22 32 F9 
[  152.870000] <-- 2) R: UIH(F)
[  152.880000] 22 
[  152.900000] F9 09 EF 03 0D 32 F9 
[  152.900000] <-- 2) R: UIH(F)
[  152.900000] 0D 
[  152.920000] F9 09 EF 0D 0D 0A 4F 4B 0D 0A D8 F9 
[  152.920000] <-- 2) R: UIH(F)
[  152.920000] 0D 0A 4F 4B 0D 0A 
[  152.950000] Q>  2) C: UIH(F)
[  152.950000] 41 
[  152.950000] F9 0B EF 03 41 53 F9 
[  152.950000] F9 0B EF 03 41 53 F9 
[  152.970000] Q>  2) C: UIH(F)
[  152.970000] 54 
[  152.970000] F9 0B EF 03 54 53 F9 
[  152.970000] F9 0B EF 03 54 53 F9 
[  152.980000] F9 09 EF 03 41 32 F9 
[  152.990000] <-- 2) R: UIH(F)
[  152.990000] 41 
[  152.990000] F9 09 EF 03 54 32 F9 
[  152.990000] <-- 2) R: 
[  153.000000] Q>  2) C: UIH(F)
[  153.000000] 44 
[  153.000000] F9 0B EF 03 44 53 F9 
[  153.000000] F9 0B EF 03 44 53 F9 
[  153.010000] UIH(F)
[  153.010000] 54 
[  153.030000] F9 
[  153.030000] Q>  2) C: UIH(F)
[  153.030000] 2A 
[  153.030000] F9 0B EF 03 2A 53 F9 
[  153.030000] F9 0B EF 03 2A 53 F9 
[  153.040000] 09 EF 03 44 32 F9 
[  153.040000] <-- 2) R: UIH(F)
[  153.050000] 44 
[  153.060000] Q>  2) C: UIH(F)
[  153.060000] 39 
[  153.060000] F9 0B EF 03 39 53 F9 
[  153.060000] F9 0B EF 03 39 53 F9 
[  153.080000] F9 09 EF 03 2A 32 F9 
[  153.080000] <-- 2) R: UIH(F)
[  153.080000] 2A 
[  153.080000] F9 09 
[  153.090000] Q>  2) C: UIH(F)
[  153.090000] 39 
[  153.090000] F9 0B EF 03 39 53 F9 
[  153.090000] F9 0B EF 03 39 53 F9 
[  153.100000] EF 03 39 32 F9 
[  153.100000] <-- 2) R: UIH(F)
[  153.110000] 39 
[  153.110000] Q>  2) C: UIH(F)
[  153.110000] 23 
[  153.110000] F9 0B EF 03 23 53 F9 
[  153.110000] F9 0B EF 03 23 53 F9 
[  153.130000] F9 09 EF 03 39 32 F9 
[  153.130000] <-- 2) R: UIH(F)
[  153.130000] 39 
[  153.130000] F9 09 
[  153.140000] Q>  2) C: UIH(F)
[  153.140000] 0D 
[  153.140000] F9 0B EF 03 0D 53 F9 
[  153.140000] F9 0B EF 03 0D 53 F9 
[  153.150000] EF 03 23 32 F9 
[  153.150000] <-- 2) R: UIH(F)
[  153.160000] 23 
[  153.180000] F9 09 EF 03 0D 32 F9 
[  153.180000] <-- 2) R: UIH(F)
[  153.180000] 0D 
[  153.230000] F9 09 EF 17 0D 0A 43 4F 4E 4E 45 43 54 0D 0A 29 
[  153.230000] F9 F9 01 EF 0B E3 07 0B 
[  153.230000] <-- 2) R: UIH(F)
[  153.240000] 0D 0A 43 4F 4E 4E 45 43 
[  153.240000] 54 0D 0A 
[  153.240000] 8D 01 79 F9 F9 09 EF 77 7E FF 7D 23 C0 21 7D 21 
[  153.250000] 7D 21 7D 20 7D 3C 7D 21 7D 24 7D 26 40 7D 23 7D 
[  153.260000] 24 C0 23 7D 25 7D 26 7D 2C 3C 65 C9 7D 22 7D 26 
[  153.260000] 7D 20 
[  153.270000] <-- 0) R: UIH(F)
[  153.270000] E3 07 0B 8D 01 
[  153.270000] Q>  0) C: UIH(F)
[  153.270000] E1 07 0B 8D 01 
[  153.270000] F9 03 EF 0B E1 07 0B 8D 01 18 F9 
[  153.270000] F9 03 EF 0B E1 07 0B 8D 01 18 F9 
[  153.290000] 7D 20 7D 20 7D 20 7D 27 7D 22 7D 28 7D 22 82 AB 
[  153.300000] 7E 61 F9 F9 09 EF 05 7E 7E D6 F9 
[  153.300000] <-- 2) R: UIH(F)
[  153.300000] 7E FF 7D 23 C0 21 7D 21 
[  153.310000] 7D 21 7D 20 7D 3C 7D 21 
[  153.310000] 7D 24 7D 26 40 7D 23 7D 
[  153.320000] 24 C0 23 7D 25 7D 26 7D 
[  153.320000] 2C 3C 65 C9 7D 22 7D 26 
[  153.320000] 7D 20 7D 20 7D 20 7D 20 
[  153.330000] 7D 27 7D 22 7D 28 7D 22 
[  153.330000] 82 AB 7E 
[  153.340000] <-- 2) R: UIH(F)
[  153.340000] 7E 7E 
[  153.350000] F9 0B 53 01 B8 F9 
[  153.350000] --> 2) C: DISC(P)
[  153.380000] F9 0B 73 01 92 F9 F9 09 EF 55 7E FF 7D 23 C0 21 
[  153.380000] 7D 25 7D 20 7D 20 7D 3D 4E 6F 72 6D 61 6C 20 54 
[  153.390000] 65 72 6D 69 6E 61 74 69 6F 6E 20 62 79 20 4E 43 
[  153.390000] 50 21 54 7E BA F9 F9 01 EF 0B E3 07 0B 0D 01 79 
[  153.400000] <-- 2) C: UA(P)
[  153.400000] <-- 2) R: UIH(F)
[  153.410000] 7E FF 7D 23 C0 21 7D 25 
[  153.410000] 7D 20 7D 20 7D 3D 4E 6F 
[  153.410000] 72 6D 61 6C 20 54 65 72 
[  153.420000] 6D 69 6E 61 74 69 6F 6E 
[  153.420000] 20 62 79 20 4E 43 50 21 
[  153.430000] 54 7E 
[  153.430000] F9 0B 1F 01 73 F9 
[  153.430000] --> 2) C: DM(P)
[  153.440000] <-- 0) R: UIH(F)
[  153.440000] E3 07 0B 0D 01 
[  153.440000] Q>  0) C: UIH(F)
[  153.440000] E1 07 0B 0D 01 
[  153.440000] F9 03 EF 0B E1 07 0B 0D 01 18 F9 
[  153.440000] F9 03 EF 0B E1 07 0B 0D 01 18 F9 
[  153.460000] F9 

microcom -s 115200 /dev/ttygsm2 :
[  257.130000] F9 0B 3F 01 59 F9 
[  257.130000] --> 2) C: SABM(P)
[  257.130000] Q>  0) C: UIH(F)
[  257.130000] E3 05 0B 0D 
[  257.130000] F9 03 EF 09 E3 05 0B 0D FB F9 
[  257.130000] F9 03 EF 09 E3 05 0B 0D FB F9 
[  257.160000] F9 0B 73 01 92 F9 F9 01 EF 0B E3 07 0B 0D 01 79 
[  257.160000] F9 
[  257.160000] <-- 2) C: UA(P)
[  257.170000] <-- 0) R: UIH(F)
[  257.170000] E3 07 0B 0D 01 
[  257.170000] Q>  0) C: UIH(F)
[  257.170000] E1 07 0B 0D 01 
[  257.170000] F9 03 EF 0B E1 07 0B 0D 01 18 F9 
[  257.170000] F9 03 EF 0B E1 07 0B 0D 01 18 F9 
[  257.190000] F9 03 EF 09 E1 05 0B 0D FB F9 
[  257.190000] <-- 0) C: UIH(F)
[  257.200000] E1 05 0B 0D 
type AT (with echo)
[  275.200000] Q>  2) C: UIH(F)
[  275.200000] 61 
[  275.200000] F9 0B EF 03 61 53 F9 
[  275.200000] F9 0B EF 03 61 53 F9 
[  275.230000] F9 09 EF 03 61 32 F9 
[  275.230000] <-- 2) R: UIH(F)
[  275.230000] 61 
[  275.430000] Q>  2) C: UIH(F)
[  275.430000] 74 
[  275.430000] F9 0B EF 03 74 53 F9 
[  275.430000] F9 0B EF 03 74 53 F9 
[  275.450000] F9 09 EF 03 74 32 F9 
[  275.450000] <-- 2) R: UIH(F)
[  275.450000] 74 
[  275.660000] Q>  2) C: UIH(F)
[  275.660000] 0D 
[  275.660000] F9 0B EF 03 0D 53 F9 
[  275.660000] F9 0B EF 03 0D 53 F9 
[  275.690000] F9 09 EF 03 0D 32 F9 F9 09 EF 0D 0D 0A 4F 4B 0D 
[  275.690000] 0A D8 F9 
[  275.690000] <-- 2) R: UIH(F)
[  275.700000] 0D 
[  275.700000] <-- 2) R: UIH(F)
[  275.700000] 0D 0A 4F 4B 0D 0A 

--------------040500060503030109070902
Content-Type: text/plain;
 name="log_telit_uc864e.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="log_telit_uc864e.txt"

[   65.480000] F9 03 3F 01 1C F9 
[   65.480000] --> 0) C: SABM(P)
[   65.500000] F9 03 73 01 D7 F9 
[   65.500000] <-- 0) C: UA(P)

launch ppp :
[   68.340000] F9 0B 3F 01 59 F9 
[   68.350000] --> 2) C: SABM(P)
[   68.350000] Q>  0) C: UIH(F)
[   68.350000] E3 05 0B 0D 
[   68.350000] F9 03 EF 09 E3 05 0B 0D FB F9 
[   68.350000] F9 03 EF 09 E3 05 0B 0D FB F9 
[   68.370000] F9 0B 73 01 92 F9 
[   68.370000] <-- 2) C: UA(P)
[   68.370000] F9 03 EF 09 E1 05 0B 0C FB F9 
[   68.380000] <-- 0) C: UIH(F)
[   68.380000] E1 05 0B 0C 
[   68.380000] Q>  0) C: UIH(F)
[   68.380000] E3 05 0B 05 
[   68.380000] F9 03 EF 09 E3 05 0B 05 FB F9 
[   68.380000] F9 03 EF 09 E3 05 0B 05 FB F9 
[   68.410000] F9 03 EF 09 E1 05 0B 0C FB F9 
[   68.410000] <-- 0) C: UIH(F)
[   68.410000] E1 05 0B 0C 
[   69.450000] Q>  2) C: UIH(F)
[   69.450000] 41 		=> A
[   69.450000] F9 0B EF 03 41 53 F9 
[   69.450000] F9 0B EF 03 41 53 F9 
[   69.480000] Q>  2) C: UIH(F)
[   69.480000] 54 		=> T
[   69.480000] F9 0B EF 03 54 53 F9 
[   69.480000] F9 0B EF 03 54 53 F9 
[   69.500000] Q>  2) C: UIH(F)
[   69.500000] 0D 		=> \r
[   69.500000] F9 0B EF 03 0D 53 F9 
[   69.500000] F9 0B EF 03 0D 53 F9
-> blocked
	-> until timeout of chat
[  114.520000] F9 0B 53 01 B8 F9 
[  114.520000] --> 2) C: DISC(P)
[  114.530000] F9 0B 73 01 92 F9 
[  114.530000] <-- 2) C: UA(P)

microcom -s 115200 /dev/ttygsm2 :
[  280.450000] F9 0B 3F 01 59 F9 
[  280.450000] --> 2) C: SABM(P)
[  280.460000] Q>  0) C: UIH(F)
[  280.460000] E3 05 0B 0D 
[  280.460000] F9 03 EF 09 E3 05 0B 0D FB F9 
[  280.460000] F9 03 EF 09 E3 05 0B 0D FB F9 
[  280.470000] F9 0B 73 01 92 F9 
[  280.470000] <-- 2) C: UA(P)
[  280.480000] F9 03 EF 09 E1 05 0B 0C FB F9 F9 09 EF 0D 0D 0A 
[  280.480000] 4F 4B 0D 0A D8 F9 
[  280.490000] <-- 0) C: UIH(F)
[  280.490000] E1 05 0B 0C 
[  280.490000] <-- 2) R: UIH(F)
[  280.500000] 0D 0A 4F 4B 0D 0A 
type AT (no echo)
[  289.130000] Q>  2) C: UIH(F)
[  289.130000] 61 
[  289.130000] F9 0B EF 03 61 53 F9 
[  289.130000] F9 0B EF 03 61 53 F9 
[  289.400000] Q>  2) C: UIH(F)
[  289.400000] 74 
[  289.400000] F9 0B EF 03 74 53 F9 
[  289.400000] F9 0B EF 03 74 53 F9 
[  290.210000] Q>  2) C: UIH(F)
[  290.210000] 0D 
[  290.210000] F9 0B EF 03 0D 53 F9 
[  290.210000] F9 0B EF 03 0D 53 F9 
[  290.230000] F9 09 EF 0D 0D 0A 4F 4B 0D 0A D8 F9 
[  290.230000] <-- 2) R: UIH(F)
[  290.230000] 0D 0A 4F 4B 0D 0A 

--------------040500060503030109070902--
